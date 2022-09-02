import csv,operator
from itertools import islice
import logging
import os
from app_store_pricing_matrix import validator
import socket
import struct
import pandas as pd
import numpy as np


def delete_file(path):
    if validator.file.validate_file(path):
        logging.debug("Deleting %s", path)
        os.remove(path)


def run(cfg):

    validator.file.validate_file(cfg["paths"]["input"], True)
    # 删除已存在的文件
    delete_file(cfg["paths"]["pricing_matrix_csv"])

    # 输入文件读取
    origin_price_file = open(cfg["paths"]["input"], "r", encoding='utf-8')
    origin_country_file = open(cfg["paths"]["input_country"], "r", encoding='utf-8')
    # 输出文件写入
    pricing_matrix_file = open(cfg["paths"]["pricing_matrix_csv"], "w", newline='', encoding='utf-8')

    # 读取价格原始文件
    reader_price = csv.reader(origin_price_file)
    reader_price_all = [row for row in reader_price]

    # 创建空的多维数组,存储遍历国家后的价格,包含等级、国家、货币、收入、对应人民币价格、对应人民币收入，以及处理后的数据
    prices =[[]]*30000

    countries = []

    row = 0
    cny_index = 0

    for i in range(len(reader_price_all)):
        # 将第1行的国家取出来
        if i == 0: # 取国家
            for k in range(len(reader_price_all[i])):
                if reader_price_all[i][k] != "" and reader_price_all[i][k] not in countries:
                    #单独处理国家名称中带","的国家
                    if reader_price_all[i][k] != "Congo" and reader_price_all[i][k] != " Democratic Republic of (USD)" and reader_price_all[i][k] != " Republic of (USD)":
                        countries.append(reader_price_all[i][k])
                    elif reader_price_all[i][k] == "Congo" :
                        countries.append(reader_price_all[i][k]+reader_price_all[i][k+1])
                    elif reader_price_all[i][k] == " Democratic Republic of (USD)" or reader_price_all[i][k] == " Republic of (USD)":
                        pass                                       
                if "CNY" in reader_price_all[i][k] and cny_index == 0:
                    cny_index = k
            continue

        # 跳过第2行（此行内容为"价格"、"收入"，无需写入结果表）
        if i == 1: 
            continue;
        # 从第3行开始处理，以列数的奇偶分别写入价格和收入
        for j in range(len(reader_price_all[i])):
            if j % 2 == 0 and int(j / 2) > 0 :
                prices[row] = []
                prices[row].append(reader_price_all[i][0]) #写入等级
                prices[row].append(countries[int((j/2))-1]) #写入国家
                prices[row].append(reader_price_all[i][j-1]) #写入价格
                prices[row].append(reader_price_all[i][j]) #写入收入
                # 当国家不为 CN 时，写入国家对应的人民币价格和收入
                if  "CNY" not in countries[int((j/2))-1]:
                    prices[row].append(reader_price_all[i][cny_index]) #写入对应人民币价格
                    prices[row].append(reader_price_all[i][cny_index+1]) #写入对应人民币收入
                # 当国家为 CN 时，国家对应的人民币价格和收入为本身价格和收入
                elif j % 2 == 0 and int(j / 2) > 0 and "CNY" in countries[int((j/2))-1] : 
                    prices[row].append(reader_price_all[i][j-1]) #写入价格
                    prices[row].append(reader_price_all[i][j]) #写入收入                     
                prices[row].append(((countries[int((j/2))-1]).split("(")[0]).rstrip()) #写入国家,先用"("分隔开，再去掉右边的空格
                # 处理未含货币代码的国家
                try:
                    prices[row].append(((countries[int((j/2))-1]).split("(")[1]).split(")")[0]) #写入货币                    
                except Exception as e:
                    prices[row].append(((countries[int((j/2))-1]).split("(")[0]))
                row = row + 1  


    # 读取国家维表文件
    reader_country = csv.reader(origin_country_file)
    reader_country_all = [row for row in reader_country]

    # 通过国家名称关联获得国家代码 
    for i in range(len(prices)):  
        for j in range(len(reader_country_all)):
            if  len(prices[i]) > 0 and prices[i][6]==reader_country_all[j][0]:
                prices[i].append(reader_country_all[j][1])
     
    # 处理为csv格式
    header = ['level', 'origin_country', 'price', 'proceeds','cny_price', 'cny_proceeds','country_name','currency_code','country_code']
    csv_writer = csv.writer(pricing_matrix_file)
    csv_writer.writerow(header)
    for i in prices:
        if len(i) != 0:
            csv_writer.writerow(i)

    # 将csv文件按照国家排序
    data = csv.reader(open('output/pricing_matrix.csv'),delimiter=',')
    sortedlist = sorted(data, key = lambda x: (x[6]))
    with open("output/pricing_matrix.csv", "w") as f:
        fileWriter = csv.writer(f, delimiter=',',dialect='unix')
        fileWriter.writerow(header)
        for row in sortedlist :
            if row:
                fileWriter.writerow(row)
    # print(csv_writer)


    origin_price_file.close()
    origin_country_file.close()
    pricing_matrix_file.close()

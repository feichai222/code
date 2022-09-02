# import csv
from difflib import Match
import operator
import logging
import os
# import pandas as pd
# import numpy as np
# from xlwt import *
import gzip
# import json
from aws_billing import validator


def delete_file(path):
    if validator.file.validate_file(path):
        logging.debug("Deleting %s", path)
        os.remove(path)


def run(cfg):
    # 删除已存在的文件
    # delete_file(cfg["paths"]["aws_billing_xlsx"])
    # input 目录
    input_path = "/home/huangdi/codebase/ingestion-configuration/aws_billing/input"
    output_path = "/home/huangdi/codebase/ingestion-configuration/aws_billing/output"

    if validator.file.validate_dir(output_path) == False:
        os.makedirs(output_path)

    # 输出文件写入
    # aws_billing_file = open(
    #     cfg["paths"]["aws_billing_xlsx"],
    #     "w", newline='', encoding='utf-8')

    file_names = []
    # 解压缩所有的 .gz 文件
    for f in os.listdir(input_path):
        if ".gz" in f:
            output_file_name = f.replace(".gz", "")
            file_names.append(output_file_name)
            output_file_path = output_path + "/" + output_file_name
            if validator.file.validate_file(output_file_path) == False:
                g = gzip.GzipFile(mode="rb", fileobj=open(input_path+"/"+f, 'rb'))
                logging.info("Extracting file:%s", output_file_name)
                open(output_path + "/" + output_file_name, "wb").write(g.read())
            else:
                logging.info("Skip %s, because file already exists!", output_file_name)
    
    file_names.sort()
    logging.info("List:%s", file_names)

    prev_file_name = ""
    prev_first_line = ""
    for file_name in file_names:
        current_file = open(output_path + "/" + file_name, "r")
        current_file_name = file_name
        current_first_line = current_file.readline()
        current_file.close()
        if prev_file_name != "" and prev_first_line != "":
            if prev_first_line != current_first_line:
                logging.info("Dimensions are different in %s and %s!", prev_file_name, current_file_name)
                logging.info("%s: %s", prev_file_name, prev_first_line)
                logging.info("%s: %s", current_file_name, current_first_line)
            else:
                logging.info("Dimensions are same in %s and %s!", prev_file_name, current_file_name)
                # logging.info("%s: %s", prev_file_name, prev_first_line)
                # logging.info("%s: %s", current_file_name, current_first_line)
                logging.info("Replace:%s", current_first_line.replace(prev_first_line, ""))
        
        prev_file_name = current_file_name
        prev_first_line = current_first_line

    prev_file_name = ""
    prev_file_lines = set()
    # lines = {}
    for file_name in file_names:
        logging.info("Filename:%s", file_name)
        # lines[file_name] = set()
        current_file = open(output_path + "/" + file_name, "r")
        current_file_name = file_name
        current_file_lines = set()
        for line in current_file.readlines():
            current_file_lines.add(line)
        current_file.close()
        if prev_file_name != "" and len(prev_file_lines) > 0:
            match_count = 0
            unmatch_count = 0
            for prev_line in prev_file_lines:
                match = False
                for current_line in current_file_lines:
                    if prev_line == current_line:
                        match = True
                        break
                if match == True:
                    match_count = match_count + 1
                else:
                    unmatch_count = unmatch_count + 1
            logging.info("prev:%s, current:%s, match:%s, unmatch:%s", 
                len(prev_file_lines), len(current_file_lines), match_count, unmatch_count)

        prev_file_name = current_file_name
        prev_file_lines = current_file_lines

    # keys_list = list(lines.keys())
    # for index in range(0, len(keys_list)):
    #     file_name = keys_list[index]
    #     logging.info("Index:%s, filename:%s, count:%s", index, file_name, len(lines[file_name]))
    #     for sub_index in range(index + 1, len(keys_list)):
    #         match_count = 0
    #         unmatch_count = 0
    #         for line in lines[keys_list[index]]:
    #             if line in lines[keys_list[sub_index]] == False:
    #                 unmatch_count = unmatch_count + 1
    #             else:
    #                 match_count = match_count + 1
    #         logging.info("prev:%s, current:%s, match:%s, unmatch:%s", 
    #             len(lines[keys_list[index]]), len(lines[keys_list[sub_index]]), match_count, unmatch_count)

    
        # if prev_file_name != "" and len(prev_file_lines) > 0:
        #     match_count = 0
        #     unmatch_count = 0
        #     for line in prev_file_lines:
        #         if line in current_file_lines == False:
        #             unmatch_count = unmatch_count + 1
        #         else:
        #             match_count = match_count + 1
        #     logging.info("prev:%s, current:%s, match:%s, unmatch:%s", 
        #         len(prev_file_lines), len(current_file_lines), match_count, unmatch_count)

        # prev_file_name = current_file_name
        # prev_file_lines = current_file_lines

    # # 取出所有解压缩出的 csv 文件名
    # csv_name_list = []
    # for file in os.listdir(input_path):
    #     if ".csv" in file and ".gz" not in file:
    #         csv_name = file.replace(".csv", "")
    #         csv_name_list.append(csv_name)

    # # 读取每一个 csv 文件
    # csv_data = locals()
    # csv_data_names = []
    # for name in csv_name_list:
    #     csv_data_file = open(
    #         input_path + "\\" + name + ".csv", "r", encoding='utf-8')
    #     reader_csv = csv.reader(csv_data_file)
    #     csv_data["csv_" + name] = [row for row in reader_csv]
    #     csv_data_names.append("csv_" + name)
    # print(csv_data_names)

    # # 分析维度数量及变化
    # dimensions_base = csv_data["csv_20220211T133623Z"][0]  # 以其中某一个 csv 的维度作为基准
    # for csv_name in csv_data_names:
    #     csv_count = len(csv_data[csv_name])
    #     # print(csv_name + " 记录总条数为：" + str(csv_count) + " ; 维度数量：" +
    #     #       str(len(csv_data[csv_name][0])))
    #     csv_dimensions = csv_data[csv_name][0]
    #     for item in csv_dimensions:
    #         if item not in dimensions_base:
    #             print("维度有变化")
    #     # 处理 identity/TimeInterval
    #     for i in range(len(csv_data[csv_name])):
    #         if i == 0:
    #             csv_data[csv_name][0].append("identity/StartTime")
    #             csv_data[csv_name][0].append("identity/EndTime")
    #         elif i > 0:
    #             for j in range(len(csv_data[csv_name][i])):
    #                 if csv_data[csv_name][0][j] == "identity/TimeInterval":
    #                     csv_data[csv_name][i].append(
    #                         csv_data[csv_name][i][j].split("/")[0])
    #                     csv_data[csv_name][i].append(
    #                         csv_data[csv_name][i][j].split("/")[1])

    # aws_billing_file.close()

import csv
from encodings import utf_8
import operator
import logging
import os
import json
from xlwt import *
from extract_json import validator


def delete_file(path):
    if validator.file.validate_file(path):
        logging.debug("Deleting %s", path)
        os.remove(path)


def run(cfg):
    # 删除已存在的文件
    delete_file(cfg["paths"]["json_xlsx"])

    # 读取 json 原始文件
    origin_json = (
        'E:\code\ingestion-configuration\extract-json\input\\tracking_json.txt')

    dict_keys = set()
    dict_list = []
    lines = open(origin_json, encoding="utf-8").readlines()
    for line in lines:
        if line:
            line_dict = json.loads(line)  # 将读取的每一行 json 转化为字典格式
            line_dict.update(line_dict.pop("properties"))   # 将 properties 中的字段打平
            dict_list.append(line_dict)
            for key in line_dict.keys():
                dict_keys.add(key)  # 取出打平后的字典所有的 key
        else:
            break
    dict_keys = list(dict_keys)

    json_result = []
    for dict in dict_list:
        tmp_list = []
        for key in dict_keys:
            if key in dict:
                tmp_list.append(dict[key])
            else:
                tmp_list.append("NULL")
        json_result.append(tmp_list)

    # 写 excel
    file = Workbook(encoding='utf-8')
    table = file.add_sheet('sheet1')
    # 添加表头
    for i in range(len(dict_keys)):
        table.write(0, i, dict_keys[i])
    # 添加内容
    k = 0
    for i, p in enumerate(json_result):
        if len(p) > 0:
            k += 1
        # 将数据写入文件,k是enumerate()函数返回的序号数
        for j, q in enumerate(p):
            table.write(k, j, q)    # 仅将结果集中不为空(即 len(p)>0) 的内容写入文件
    file.save('output/json.xlsx')

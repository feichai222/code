import csv
from encodings import utf_8
import operator
import logging
import os
from validate_tracking_data import validator


def delete_file(path):
    if validator.file.validate_file(path):
        logging.debug("Deleting %s", path)
        os.remove(path)


def run(cfg):
    # 输入文件读取
    tracking_document_file = open(
        cfg["paths"]["input_tracking_document"],
        "r", encoding='utf-8')
    tracking_data_file = open(
        cfg["paths"]["input_tracking_data"],
        "r", encoding='utf-8')

    reader_tracking_document = csv.reader(tracking_document_file)
    tracking_document = [row for row in reader_tracking_document]

    reader_tracking_data = csv.reader(tracking_data_file)
    tracking_data = [row for row in reader_tracking_data]

    # 将埋点文档的 event_id 和 network 取出来并拼接成一个字符串，存到 list 里
    tracking_document_list = [[]] * len(tracking_document)
    # 取出表头有效列数
    column = 0
    for k in range(len(tracking_document[0])):
        if tracking_document[0][k] != "":
            column = column + 1

    list_standard = []
    for i in range(1, len(tracking_document)):
        for j in range(column):
            if tracking_document[0][j] == "event_id":
                for a in range(column):
                    if tracking_document[0][a] == "network":
                        list_standard.append(
                            tracking_document[i][j] + "," +
                            tracking_document[i][a])

    # 将埋点数据的 event_id 和 network 拼接成一个字符串
    tracking_data_list = [[]] * len(tracking_data)
    list_data = []
    for i in range(1, len(tracking_data)):
        for j in range(len(tracking_data[i])):
            if tracking_data[0][j] == "event_id":
                for a in range(len(tracking_data[i])):
                    if tracking_data[0][a] == "network" and tracking_data[i][
                            a] != "Error":
                        list_data.append(
                            tracking_data[i][j] + "," +
                            tracking_data[i][a].replace('-', ''))
                    elif tracking_data[0][a] == "network" and tracking_data[i][a] == "Error":
                        logging.info("埋点记录存在 bug :%s", tracking_data[i])
    # 比较埋点数据和埋点文档的差异
    for a in list_standard:
        if a not in list_data:
            logging.info("没有该埋点数据 %s", a)

    tracking_document_file.close()
    tracking_data_file.close()

import csv
import operator
import logging
import os
import pandas as pd
import numpy as np
from xlwt import *
from zipfile import ZipFile
from oversea_collector_billing import validator


def delete_file(path):
    if validator.file.validate_file(path):
        logging.debug("Deleting %s", path)
        os.remove(path)


def run(cfg):
    # 删除已存在的文件
    delete_file(cfg["paths"]["oversea_collector_billing_xlsx"])
    # input 目录
    input_path = "E:\code\ingestion-configuration\oversea_collector_billing\input"

    # 输出文件写入
    oversea_collector_billing_file = open(
        cfg["paths"]["oversea_collector_billing_xlsx"],
        "w", newline='', encoding='utf-8')

    # 读取海外项目 mapping 表
    oversea_project_mapping_file = open(
        cfg["paths"]["input_oversea_project_mapping"],
        "r", encoding='utf-8')

    # 读取海外项目日志表
    # Step 1: 获取压缩文件名
    def get_filename(path, filetype):  # 输入路径、文件类型 例如'.csv'
        name = []
        for root, dirs, files in os.walk(path):
            for i in files:
                if os.path.splitext(i)[1] == filetype:
                    name.append(i)
                    if len(name) >= 2:
                        raise Exception('input 文件夹里存在不止一个 zip 文件,请检查!')
        return name
    name = get_filename(input_path, '.zip')
    filename = "".join(name)
    zipname = input_path+"\\" + filename
    # Step 2: 解压缩文件
    z = ZipFile(zipname, 'r')
    for name in z.namelist():
        file = z.extract(
            name, input_path)
    # Step 3: 读取解压出来的 csv
    ovesea_collector_data_file = open(
        input_path + "\\" + name, "r",
        encoding='utf-8')

    # 读取海外项目日志量统计数据和海外项目维表
    reader_collector_data = csv.reader(ovesea_collector_data_file)
    reader_collector_data_all = [row for row in reader_collector_data]
    reader_project_mapping = csv.reader(oversea_project_mapping_file)
    reader_project_mapping_all = [row for row in reader_project_mapping]

    # 转换 input 文件的 csv 中的日期格式
    reader_collector_data_all = pd.DataFrame(reader_collector_data_all)
    reader_collector_data_all.loc[:, '月份'] = pd.to_datetime(
        reader_collector_data_all.loc[:, 0], format='%b-%y', errors='coerce')
    collector_data_array = np.array(reader_collector_data_all)
    collector_data_list = collector_data_array.tolist()

    # 创建空的多维数组,写入通过项目维表获得的标准项目名称的 collector_data
    n = len(collector_data_list)
    collector_data = [[]]*n
    row = 0
    for i in range(len(collector_data_list)):
        for j in range(len(reader_project_mapping_all)):
            if collector_data_list[i][1] == reader_project_mapping_all[j][0]:
                collector_data[row] = []
                collector_data[row].append(
                    str(collector_data_list[i][0]).replace('-', '')[0:6])
                collector_data[row].append(reader_project_mapping_all[j][1])
                collector_data[row].append(
                    int(collector_data_list[i][3]))
                row = row + 1

    col_names = ('month', 'project_name', 'log_count')
    collector_data = pd.DataFrame(collector_data, columns=col_names)

    # 将得到的 collector_data 按照标准的项目名称聚合，并升序排列
    log_count = collector_data['log_count'].groupby(
        [collector_data['month'], collector_data['project_name']]).sum().reset_index()
    log_count_data = log_count.sort_values('log_count', ascending=True)

    # 计算占比
    log_count_data = np.array(log_count_data)
    log_count_all = collector_data['log_count'].sum()
    m = len(log_count_data)
    log_count_percent = [[]]*m
    row = 0
    pencent_sum = 0
    for i in range(len(log_count_data)):
        if i < len(log_count_data)-1:
            if round(log_count_data[i][2]/log_count_all*100, 2) >= 0.01:
                log_count_percent[row] = []
                log_count_percent[row].append('海外数据收集')
                log_count_percent[row].append(log_count_data[i][1])
                log_count_percent[row].append(log_count_data[i][0])
                log_count_percent[row].append(
                    round(log_count_data[i][2]/log_count_all*100, 2))
                row = row + 1
                pencent_sum += round(log_count_data[i][2]/log_count_all*100, 2)
            else:
                row = row + 1
        elif i == len(log_count_data)-1:
            log_count_percent[row] = []
            log_count_percent[row].append('海外数据收集')
            log_count_percent[row].append(log_count_data[i][1])
            log_count_percent[row].append(log_count_data[i][0])
            log_count_percent[row].append(100-pencent_sum)
    # 写 excel
    file = Workbook(encoding='utf-8')
    table = file.add_sheet('sheet1')
    table.write(0, 0, '无产品号项目ID')
    table.write(0, 1, '项目 ID')
    table.write(0, 2, '计费月份')
    table.write(0, 3, '分摊百分比')
    k = 0
    for i, p in enumerate(log_count_percent):
        if len(p) > 0:
            k += 1
        # 将数据写入文件,k是enumerate()函数返回的序号数
        for j, q in enumerate(p):
            table.write(k, j, q)    # 仅将结果集中不为空(即 len(p)>0) 的内容写入文件
    file.save('output/oversea_collector_billing.xlsx')

    ovesea_collector_data_file.close()
    oversea_project_mapping_file.close()
    oversea_collector_billing_file.close()

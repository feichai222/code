import os
import logging


# 检查指定的目录是否存在
def validate_dir(path, enable_log=False):
    result = True
    if not os.path.exists(path):
        if enable_log:
            logging.error("Dir %s not exist!", path)
        result = False
    elif not os.path.isdir(path):
        if enable_log:
            logging.error("Dir %s is not dir!", path)
        result = False
    return result


# 检查指定文件是否存在
def validate_file(path, enable_log=False):
    result = True
    if not os.path.exists(path):
        if enable_log:
            logging.error("File %s not exist!", path)
        result = False
    elif not os.path.isfile(path):
        if enable_log:
            logging.error("File %s is not file!", path)
        result = False
    return result


# 检查指定的目录下是否存在指定后缀的文件
def validate_file_in_dir(path, file_ext, enable_log=False):
    result = False
    for file_path, dirs, fs in os.walk(path):
        for file in fs:
            if os.path.splitext(file)[1] in file_ext:
                result = True
                break
        if result:
            break
    if not result and enable_log:
        logging.error(
            "Dir %s doesn't contain file with extensions:%s", path, file_ext)
    return result

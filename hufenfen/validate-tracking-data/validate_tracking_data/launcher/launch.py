import logging
import os
import sys
import yaml
import codecs

from validate_tracking_data import validator


# 初始化 Logging
def init_logging(cfg):
    log_level = logging.getLevelName(cfg["log"]["level"].upper())
    log_format = "%(asctime)s,%(module)s:%(lineno)d,%(levelname)s:%(message)s"
    logging.basicConfig(format=log_format, level=log_level)
    logging.debug("Logging init finished")


def check_config(cfg_dict, key, value):
    if key not in cfg_dict:
        cfg_dict[key] = value


# 加载配置文件
def load_config():
    cfg = None
    config_file_path = os.getcwd() + os.sep + "config.yml"
    if validator.file.validate_file(config_file_path, False):
        cfg = yaml.load(codecs.open(config_file_path, "r",
                                    "utf-8"), Loader=yaml.SafeLoader)

    if cfg is None:
        cfg = {}

    # 日志的默认配置
    check_config(cfg, "log", {})
    check_config(cfg["log"], "level", "INFO")

    # 路径的默认配置
    check_config(cfg, "paths", {})
    check_config(cfg["paths"], "input_tracking_document", os.getcwd() + os.sep + "input" + os.sep + "tracking_document.csv")
    check_config(cfg["paths"], "input_tracking_data", os.getcwd() + os.sep + "input" + os.sep + "tracking_data.csv")  

    return cfg


# 执行初始化操作
def init():
    sys.path.append(os.getcwd() + os.sep + "json")
    # load configuration file
    cfg = load_config()
    # init logging
    init_logging(cfg)

    return cfg

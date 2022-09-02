#!/usr/bin/env python
import logging

from . import launcher
from . import validator
from . import processor


def main():
    # init by launcher
    user_cfg = launcher.launch.init()
    logging.info("configuration:%s", user_cfg)

    # run processor
    processor.transform.run(user_cfg)


if __name__ == "__main__":
    main()

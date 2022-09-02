import logging
import boto3
import os
import yaml

boto3.set_stream_logger('boto3.resources', logging.DEBUG)
# 下载所属文件路径下的所有文件
input = 'bill/lab-bills/20220201-20220301'
# 输出的本地路径
output = '/home/huangdi/codebase/ingestion-configuration/aws_billing/input'
# 初始化 s3
s3 = boto3.resource("s3")
# 选择要下载的桶 id
bucket = s3.Bucket("lab-billings")


def getDir():
    for obj in bucket.objects.all():
        objList = obj.key.split('/')
        # 获得文件路径
        endDir = objList
        endDir.pop(-1)

        # 当 s3 路径与 input 匹配时，下载此路径下的所有文件
        if input in obj.key:
            path = ''
            for i in endDir:
                path = path + '/' + i
            # 在本地创建与 s3 中相同的路径
            if not os.path.exists(output + '/' + path):
                os.makedirs(output + '/' + path)
            # 下载文件
            s3.meta.client.download_file(
                'lab-billings',
                obj.key,
                output + '/' + obj.key.split('/')[-2] + '.' + obj.key.split('/')[-1])


def main():
    getDir()


if __name__ == "__main__":
    main()

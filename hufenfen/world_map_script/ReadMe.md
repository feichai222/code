本脚本需要 wiki-country-code.csv 作为依赖文件。

wiki-country-code.csv 的数据来源为[维基百科](https://zh.wikipedia.org/wiki/ISO_3166-1)，国家名称及缩写代码遵循 ISO_3166-1 标准，部分维度参考蓝鲸平台[国家维度表](https://whale.xoyo.com/query/ajaxQuery.do?queryId=13844843)

更新字段的数据来源是[Highmaps 地图数据集](https://img.hcharts.cn/mapdata/)的[世界地图数据](https://img.hcharts.cn/mapdata/custom/world-palestine-highres.geo.json)

需要在脚本内修改：

1. wiki-country-code.csv 的文件路径
2. 生成 csv 的路径

执行：

需要在命令行中输入 python 命令和脚本路径

例：python c:/Users/Administrator/git/data/ingestion-configuration/world_map_script/world_map_script.py


import requests
import json
import os

# 地图 json 的连接
geo_json = "https://img.hcharts.cn/mapdata/custom/world-palestine-highres.geo.json"
# 维基百科上的国家代码表，附带蓝鲸的中文国家名
old_dim_wiki_country_code = "./wiki-country-code.csv"
# 输出最终的 wiki 国家代码维度表
new_wiki_csv = "./dim_wiki_country_code.csv"


# 维基百科国家信息
wiki_line = []


# 添加蓝鲸中文国家名到维基国家表中
def get_whales_name_and_code():
    country_code_list = []
    country_code = open(old_dim_wiki_country_code, "r", encoding="utf-8")
    for line in country_code:
        wiki_line.append(line)
        # 无 geojson 国家列的 wiki 维度表
        if len(line.split(",")) == 7:
            if line.split(",")[6] == "\n":
                country_code_list.append({line.split(",")[1]: line.split(",")[5].split("\n")[0]})
            elif line.split(",")[6] != "\n":
                country_code_list.append({line.split(",")[1]: line.split(",")[6].split("\n")[0]})
        # 有 geojson 国家列的 wiki 维度表
        elif len(line.split(",")) > 7:
            if line.split(",")[6] == "":
                country_code_list.append({line.split(",")[1]: line.split(",")[5].split("\n")[0]})
            if line.split(",")[6] != "":
                country_code_list.append({line.split(",")[1]: line.split(",")[6]})
    country_code.close()
    return country_code_list


# 判断是否是 json 格式
def is_json(myjson):
    try:
        json_object = json.loads(myjson)
    except ValueError as e:
        return False
    return True


# 添加 geojson 中英文与蓝鲸中文的对应关系
def connect_geojson_and_whales_name(map_json, country_code_list):
    name_Map = {}
    all_country_list = []
    if is_json(map_json):
        # 字符串解析为 json
        json_data = json.loads(map_json)
        # 解析 geojson 内容，去除坐标信息
        for item in json_data:
            if item == 'features':
                for section in json_data[item]:
                    for part in section:
                        get_list = []
                        # 去除无用的字段 admine0
                        if part == 'properties':
                            for cell in section[part]:
                                if cell == 'hc-group':
                                    continue
                                get_list.append(section[part][cell])
                        # 过滤不符合需求的信息
                        if len(get_list) != 0:
                            for item in country_code_list:
                                if get_list[10] in item.keys():
                                    get_list.append(item[get_list[10]])
                            all_country_list.append(get_list)
    # name_Map 是在 地图.js 文件中需要添加的映射关系，把地图改为中文显示
    # 可打印出 name_Map 后，复制到 .js 文件中,也可在最后生成的 csv 文件中获得此对应关系
    for line in all_country_list:
        name_Map[line[4]] = line[-1]

    return all_country_list


# 添加 geojson 英文名
def get_new_dim_wike_country_code(all_country_list):
    new_wiki_line = []
    get_wiki_line = []
    for line in all_country_list:
        for item in wiki_line:
            tmp_line = []
            num = 0
            if line[10] == item.split(',')[1].split('"')[1]:
                for cell in item.split(','):
                    cell = cell.split('\n')[0]
                    tmp_line.append(cell.replace('"', ''))
                tmp_line.append(line[4].replace('"', ''))

            if len(tmp_line) != 0:
                new_wiki_line.append(tmp_line)
    # 防止重复添加英文名
    for line in new_wiki_line:
        if len(line) > 8:
            get_wiki_line.append(line[0: 8])
        else:
            get_wiki_line.append(line)
    return get_wiki_line


# 把 geojson 英文名写入到 wiki 的国家代码维度表中
def get_new_wike_csv(all_country_list):
    new_wiki_line = get_new_dim_wike_country_code(all_country_list)
    delete_file(new_wiki_csv)
    write_wiki_country_code = open(new_wiki_csv, "w", encoding="utf-8")
    for line in new_wiki_line:
        for cell in line:
            write_wiki_country_code.write(cell + ",")
        write_wiki_country_code.write('\n')
    write_wiki_country_code.close()


def delete_file(path):
    if os.path.exists(path):
        os.remove(path)


def main():
    # 获得 json 内容
    map_json = requests.get(geo_json).content
    country_code_list = get_whales_name_and_code()
    all_country_list = connect_geojson_and_whales_name(map_json, country_code_list)
    get_new_wike_csv(all_country_list)


if __name__ == "__main__":
    main()

function preCall(option, resultSet, myChart) {
    //option 标准的echart配置
    //datas 要展现的查询结果
    //myChart echart对象
    //定制开始 console.log(option) 可以查看对象结构
    var events = [];
    var dimensions = new Array("country", "host", "url_path", "sdk_version", "vendor", "device_model", "os_version");
    for (let key in resultSet) {
        var name = ""
        var booleanAddSpace = false
        // 遍历所有维度
        for (var index = 0; index < dimensions.length; index++) {
            var dimension = dimensions[index]
            // 处理未被定义的字段
            if (typeof (resultSet[key][dimension]) == "undefined") {
                resultSet[key][dimension] = ""
            }
            // 将字段为空的值命名为 N/A
            if (resultSet[key][dimension] == null) {
                resultSet[key][dimension] = "N/A"
            }
            if (resultSet[key][dimension] != '') {
                if (booleanAddSpace == false) {
                    booleanAddSpace = true
                } else {
                    name = name + " "
                }
                name = name + resultSet[key][dimension]
            }
        }
  
        var item = {};
        item["value"] = resultSet[key].api_cnt;
        var reg = RegExp(/others/)
        if (reg.test(name)) { name = "others" }
        item["name"] = name;
        events.push(item);
    }

    option = {
        tooltip: {
            trigger: 'item'
        },
        toolbox: {
            show: true,
            feature: {
                mark: {
                    show: true
                },
                dataView: {
                    show: true,
                    readOnly: false
                },
                saveAsImage: {
                    show: true
                }
            }
        },
        series: [{
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
                borderRadius: 20,
                borderColor: '#fff',
                borderWidth: 5
            },
            avoidLabelOverlap: true,
            label: {
                show: false,
                position: 'center'
            },
            label: {
                show: true,
                formatter: '{b}：\n{c}，{d}%',
                textStyle: {
                      fontSize: 11
                        }
            },
            data: events
        }]
    };
    //定制结束
    return option;
}

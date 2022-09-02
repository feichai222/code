function preCall(option, resultSet, myChart) {
    var topn = 4;
    var topnList = [];
    var events = [];
    var dimensions = new Array("game_name", "version", "product_type", "region");
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
        item["value"] = resultSet[key].units;
        var reg = RegExp(/others/)
        if (reg.test(name)) { name = "others" }
        item["name"] = name;
        events.push(item);
    }

    var endValue = 0
    for (var i = 0; i < events.length; i++) {
        if (i < topn) {
            topnList.push(events[i])
        }
        else {
            endValue = endValue + events[i].value
        }
    }
    if (endValue != 0) {
        topnList.push({ value: endValue, name: 'others' })
    }

    for (var i = 0; i < topnList.length; i++) {
        for (var j = i; j < topnList.length; j++) {
            if (topnList[i]['value'] < topnList[j]['value']) {
                max = topnList[j];
                topnList[j] = topnList[i];
                topnList[i] = max;
            }
        }
    }
  option = {
      toolbox: {
          show: true,
          feature: {
              mark: { show: true },
              dataView: { show: true, readOnly: false },
              saveAsImage: { show: true }
          }
      },
      series: [
          {
              name: 'Nightingale Chart',
              type: 'pie',
              radius: [80, 200],
              center: ['50%', '50%'],
              roseType: 'area',
              itemStyle: {
                  borderRadius: 15,
                  borderColor: '#fff',
                  borderWidth: 3
              },
              label: {
                  show: true,
                  formatter: '{b}：\n下载数量 {c},占比{d}%',
                  textStyle: {
                      fontSize: 13
                  }
              },
              itemStyle: {
                  borderRadius: 8
              },
              data: topnList
          }
      ]
  };
  //定制结束
  return option;
}

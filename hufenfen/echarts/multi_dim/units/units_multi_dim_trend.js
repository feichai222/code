function preCall(option, resultSet, myChart) {
    //option 标准的echart配置
    //datas 要展现的查询结果
    //myChart echart对象
    //定制开始 console.log(option) 可以查看对象结构
    var dts = new Set();
    var concat_names =new Set();
    var series = []
    var dimensions = new Array("game_name", "version", "product_type", "region");

    for (let key in resultSet) {
        var data_item = resultSet[key]
        dts.add(data_item.dt);
        concat_names.add(contactName(data_item,dimensions));
    }


    var concat_names1 = Array.from(concat_names)
    for (let j in concat_names1) {
         let item = {
              name: concat_names1[j],
              type: 'line',
             data: [],
             showAllSymbol: true,
             smooth: false,  //true 为平滑曲线，false为直线
             symbol:'circle',
             symbolSize:7,
             label : {show: false},// 拐点上显示数值
             lineStyle: {
                     width: 2,  // 设置线宽
                     type: 'solid'  //'dotted'虚线 'solid'实线
                 },
          }
        series.push(item)
       }

      for (let i in resultSet) {
          let data_item = resultSet[i];
          let name = contactName(data_item,dimensions)
        for (let j in concat_names1) {
          if(name === concat_names1[j]){
            series[j].data.push(data_item.units)
          }
        }
      }

    option = {
        tooltip: {
          trigger: 'axis'
        },
        legend: {
            data: Array.from(concat_names)
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        toolbox: {
          feature: {
            saveAsImage: {}
          }
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: Array.from(dts)
        },
        yAxis: {
          type: 'value'
        },
        series: series
    };
    //定制结束
  return option;
}


  function contactName(data_item, dimensions){
      let name = "";
      var booleanAddSpace = false
    // 遍历所有维度
    for (var index = 0; index < dimensions.length; index++) {
        var dimension = dimensions[index]
        // 处理未被定义的字段
        if (typeof (data_item[dimension]) == "undefined") {
            data_item[dimension] = ""
        }
        // 将字段为空的值命名为 N/A
        if (data_item[dimension] == null) {
            data_item[dimension] = "N/A"
        }
        if (data_item[dimension] != '') {
            if (booleanAddSpace == false) {
                booleanAddSpace = true
            } else {
                name = name + " "
            }
            name = name + data_item[dimension]
        }
    }
    var reg = RegExp(/others/)
    if (reg.test(name)) { name = "others" }
    return name
}

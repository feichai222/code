function preCall(option, resultSet, myChart) {
  //option 标准的echart配置
  //datas 要展现的查询结果
  //myChart echart对象
  //定制开始 console.log(option) 可以查看对象结构
  var events = [];
  var topn = 6;
  var topnList = [];
  for (let key in resultSet) {
      //处理未被定义的字段
      if (typeof(resultSet[key].game_name) == "undefined") {
          resultSet[key].game_name = ""
      } else {
          resultSet[key].game_name
      }
      //将字段为空的值命名为 N/A
      if (resultSet[key].game_name == null) {
          resultSet[key].game_name = "N/A"
      } else {
          resultSet[key].game_name
      }
      var name = resultSet[key].game_name;
      var item = {};
      item["value"] = resultSet[key].units;
      item["name"] = name;
      events.push(item);
  }

  var max
  for (var i = 0; i < events.length; i++) {
      for (var j = i; j < events.length; j++) {
          if (events[i]['value'] < events[j]['value']) {
              max = events[j];
              events[j] = events[i];
              events[i] = max;
          }
      }
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
  if (endValue != 0){
      topnList.push({ value: endValue, name: 'others' })
  }

  var maxTopn
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
      tooltip: {
          trigger: 'item',
          textStyle: {
              fontSize: '16px',
              color: '#000'  // 设置文本颜色 默认#FFF
            },

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
              show: true,
              formatter: '{b}：\n{c}，{d}%',
              textStyle: {
                      fontSize: 11
                  }
          },
          data: topnList
      }]
  };
  //定制结束
  return option;
}

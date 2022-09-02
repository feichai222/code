function preCall(option, resultSet, myChart) {
  //option 标准的echart配置
  //datas 要展现的查询结果
  //myChart echart对象
  //定制开始 console.log(option) 可以查看对象结构
  var events = [];
  var dim = [];
for (let key in resultSet) 
{
    var item = {};
    var xis = {};
    xis["value"] = resultSet[key].dt;
    item["value"] = resultSet[key].api_cnt;
    events.push(item);
    dim.push(xis);
  }

  option = {
      tooltip: {
        trigger: 'axis'
      },
      grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
      },
    toolbox: {
      show: true,
      feature: {
        mark: { show: true },
        dataView: { show: true, readOnly: false },
        saveAsImage: { show: true }
      }
    },
      xAxis: {
        type: 'category',
        boundaryGap: false,
        data: dim
      },
      yAxis: {
        type: 'value'
      },
      series: [
        {
          type: 'line',
          stack: 'Total',
          showAllSymbol: true,
          smooth: false,  //true 为平滑曲线，false为直线
          symbol:'circle',
          symbolSize:6,
          label : {show: false},// 拐点上显示数值
          borderColor:'red',  // 拐点边框颜色
          lineStyle: {
                  width: 2,  // 设置线宽
                  type: 'solid'  //'dotted'虚线 'solid'实线
              },
              data: events
        }
      ]
    };
  //定制结束
return option;
}

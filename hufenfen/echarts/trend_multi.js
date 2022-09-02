function preCall(option, resultSet, myChart) {
  var dts = new Set();
  var flags =new Set();
  var series = []
for (let i in resultSet) 
{
  let item = resultSet[i];
  dts.add(item.dt)
  flags.add(item.flag)
}
  var flags1 = Array.from(flags)
  for (let j in flags1) {
       let item = {
            name: flags1[j],
            type: 'line',
            stack: 'Total',
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
        let item = resultSet[i];
      for (let j in series) {
        if(item.flag === series[j].name){
          series[j].data.push(item.api_cnt)
        }
      }
    }

  option = {
      tooltip: {
        trigger: 'axis'
      },
      legend: {
          data: Array.from(flags)
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

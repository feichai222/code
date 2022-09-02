function (option, datas, myChart) {
    events = []
    for (let key in datas) {
        item = {}
        if (typeof (datas[key].country_name) == "undefined") {
            continue
        }
        item["name"] = datas[key].country_name
        if (datas[key].api_cnt == null) {
            item["value"] = 0
        } else {
            item["value"] = datas[key].api_cnt
        }
        events.push(item)
    }

    var max_value = 0
    for (var i = 0; i < events.length; i++) {
        if (max_value < events[i]["value"]) {
            max_value = events[i]["value"]
        }
    }

    value_sort = []
    for (var i = 0; i < events.length; i++) {
        value_sort.push(events[i]["value"])
    }
    // 冒泡排序,从小到大
    for (var i = 0; i < value_sort.length - 1; i++) {
        for (var j = 0; j < value_sort.length - 1 - i; j++) {
            if (value_sort[j] > value_sort[j + 1]) {
                var temp = value_sort[j];
                value_sort[j] = value_sort[j + 1];
                value_sort[j + 1] = temp;
            }
        }
    }

    myChart.showLoading();
    $.get(
        'https://img.hcharts.cn/mapdata/custom/world-palestine-highres.geo.json',
        function (worldJson) {
            myChart.hideLoading();
            echarts.registerMap('WORD', worldJson);
            option = {
                title: {
                    text: 'API 访问次数世界地图',
                    subtext: '',
                    sublink: '',
                    left: 'right'
                },
                tooltip: {
                    trigger: 'item',
                    showDelay: 0,
                    transitionDuration: 0.2,
                    formatter: function (params) {
                        const value = (params.value + '').split('.');
                        const valueStr = value[0];
                        return params.seriesName + '<br/>' + params.name + ': ' + valueStr;
                    }
                },
                visualMap: {
                    left: 'right',
                    min: 0,
                    max: value_sort[value_sort.length-10],
                    inRange: {
                        color: [
                            '#ffffbf',
                            '#fee090',
                            '#fdae61',
                            '#f46d43',
                            '#d73027',
                            '#a50026'
                        ]
                    },
                    text: ['High', 'Low'],
                    calculable: false
                },
                toolbox: {
                    show: true,
                    left: 'left',
                    top: 'top',
                    feature: {
                        dataView: { readOnly: false },
                        restore: {},
                        saveAsImage: {}
                    }
                },
                series: [
                    //悬浮显示信息
                    {
                        name: 'API 访问次数',
                        type: 'map',
                        center: [7306,6547],
                        zoom: 3.5,
                        roam: true,
                        map: 'WORD',
                        emphasis: {
                            label: {
                                show: true
                            }
                        },
                        data: events,
                        nameMap: {
                            Greenland: '格陵兰',
                            'Scarborough Reef': '圣赫勒拿、阿森松和特里斯坦-达库尼亚',
                            'Sri Lanka': '斯里兰卡',
                            'American Samoa': '美属萨摩亚',
                            Denmark: '丹麦',
                            'Faroe Islands': '法罗群岛',
                            Guam: '关岛',
                            'Northern Mariana Islands': '北马里亚纳群岛',
                            'United States Minor Outlying Islands': '美国本土外小岛屿',
                            'United States of America': '美国',
                            'United States Virgin Islands': '美属维尔京群岛',
                            Canada: '加拿大',
                            'Sao Tome and Principe': '圣多美和普林西比',
                            Japan: '日本',
                            'Cape Verde': '佛得角',
                            Dominica: '多米尼克',
                            Seychelles: '塞舌尔',
                            'New Zealand': '新西兰',
                            Yemen: '也门',
                            Jamaica: '牙买加',
                            Samoa: '萨摩亚',
                            Oman: '阿曼',
                            India: '印度',
                            'Saint Vincent and the Grenadines': '圣文森特和格林纳丁斯',
                            Bangladesh: '孟加拉国',
                            'Solomon Islands': '所罗门群岛',
                            'Saint Lucia': '圣卢西亚',
                            France: '法国',
                            Nauru: '瑙鲁',
                            Norway: '挪威',
                            'Federated States of Micronesia': '密克罗尼西亚联邦',
                            'Saint Kitts and Nevis': '圣基茨和尼维斯',
                            China: '中国',
                            Bahrain: '巴林',
                            Tonga: '汤加',
                            Finland: '芬兰',
                            Indonesia: '印尼',
                            Mauritius: '毛里求斯',
                            Sweden: '瑞典',
                            'Trinidad and Tobago': '特立尼达和多巴哥',
                            Brazil: '巴西',
                            'The Bahamas': '巴哈马',
                            Palau: '帕劳',
                            Ecuador: '厄瓜多尔',
                            Australia: '澳大利亚',
                            Tuvalu: '图瓦卢',
                            'Marshall Islands': '马绍尔群岛',
                            Chile: '智利',
                            Kiribati: '基里巴斯',
                            Philippines: '菲律宾',
                            Grenada: '格林纳达',
                            Estonia: '爱沙尼亚',
                            'Antigua and Barbuda': '安提瓜和巴布达',
                            Spain: '西班牙',
                            Barbados: '巴巴多斯',
                            Italy: '意大利',
                            Malta: '马耳他',
                            Maldives: '马尔代夫',
                            'Papua New Guinea': '巴布亚新几内亚',
                            Vanuatu: '瓦努阿图',
                            Singapore: '新加坡',
                            'United Kingdom': '英国',
                            Cyprus: '塞浦路斯',
                            Greece: '希腊',
                            Comoros: '科摩罗',
                            Fiji: '斐济',
                            Russia: '俄罗斯',
                            Vatican: '梵蒂冈',
                            'San Marino': '圣马力诺',
                            Armenia: '亚美尼亚',
                            Azerbaijan: '阿塞拜疆',
                            Lesotho: '莱索托',
                            Tajikistan: '塔吉克斯坦',
                            Mali: '马里',
                            Algeria: '阿尔及利亚',
                            Taiwan: '中华民国 中国台湾省',
                            Uzbekistan: '乌兹别克斯坦',
                            'United Republic of Tanzania': '坦桑尼亚',
                            Argentina: '阿根廷',
                            'Saudi Arabia': '沙特阿拉伯',
                            Netherlands: '荷兰',
                            'United Arab Emirates': '阿联酋',
                            Switzerland: '瑞士',
                            Portugal: '葡萄牙',
                            Malaysia: '马来西亚',
                            Panama: '巴拿马',
                            Turkey: '土耳其',
                            Iran: '伊朗',
                            Haiti: '海地',
                            'Dominican Republic': '多米尼加',
                            'Guinea Bissau': '几内亚比绍',
                            Croatia: '克罗地亚',
                            Thailand: '泰国',
                            Mexico: '墨西哥',
                            Kuwait: '科威特',
                            Germany: '德国',
                            'Equatorial Guinea': '赤道几内亚',
                            'Northern Cyprus': '新喀里多尼亚',
                            Ireland: '爱尔兰',
                            Kazakhstan: '哈萨克斯坦',
                            Georgia: '格鲁吉亚',
                            Poland: '波兰',
                            Lithuania: '立陶宛',
                            Uganda: '乌干达',
                            'Democratic Republic of the Congo': '刚果民主共和国',
                            Macedonia: '北马其顿',
                            Albania: '阿尔巴尼亚',
                            Nigeria: '尼日利亚',
                            Cameroon: '喀麦隆',
                            Benin: '贝宁',
                            'East Timor': '东帝汶',
                            Turkmenistan: '土库曼斯坦',
                            Cambodia: '柬埔寨',
                            Peru: '秘鲁',
                            Malawi: '马拉维',
                            Mongolia: '蒙古',
                            Angola: '安哥拉',
                            Mozambique: '莫桑比克',
                            'South Africa': '南非',
                            'Costa Rica': '哥斯达黎加',
                            'El Salvador': '萨尔瓦多',
                            Belize: '伯利兹',
                            Colombia: '哥伦比亚',
                            'North Korea': '朝鲜',
                            'South Korea': '韩国',
                            Guyana: '圭亚那',
                            Honduras: '洪都拉斯',
                            Gabon: '加蓬',
                            Nicaragua: '尼加拉瓜',
                            Ethiopia: '埃塞俄比亚',
                            Sudan: '苏丹',
                            Somalia: '索马里',
                            Ghana: '加纳',
                            'Ivory Coast': '科特迪瓦',
                            Slovenia: '斯洛文尼亚',
                            Guatemala: '危地马拉',
                            'Bosnia and Herzegovina': '波黑',
                            Jordan: '约旦',
                            Syria: '叙利亚',
                            Israel: '以色列',
                            Egypt: '埃及',
                            Zambia: '赞比亚',
                            Monaco: '摩纳哥',
                            Uruguay: '乌拉圭',
                            Rwanda: '卢旺达',
                            Bolivia: '玻利维亚',
                            'Republic of Congo': '刚果共和国',
                            'Western Sahara': '西撒哈拉',
                            'Republic of Serbia': '塞尔维亚',
                            Montenegro: '黑山',
                            Togo: '多哥',
                            Myanmar: '缅甸',
                            Laos: '老挝',
                            Afghanistan: '阿富汗',
                            Pakistan: '巴基斯坦',
                            Bulgaria: '保加利亚',
                            Ukraine: '乌克兰',
                            Romania: '罗马尼亚',
                            Qatar: '卡塔尔',
                            Liechtenstein: '列支敦士登',
                            Austria: '奥地利',
                            Slovakia: '斯洛伐克',
                            Swaziland: '斯威士兰',
                            Hungary: '匈牙利',
                            Libya: '利比亚',
                            Niger: '尼日尔',
                            Luxembourg: '卢森堡',
                            Andorra: '安道尔',
                            Liberia: '利比里亚',
                            'Sierra Leone': '塞拉利昂',
                            Brunei: '文莱',
                            Mauritania: '毛里塔尼亚',
                            Belgium: '比利时',
                            Iraq: '伊拉克',
                            Gambia: '冈比亚',
                            Morocco: '摩洛哥',
                            Chad: '乍得',
                            Lebanon: '黎巴嫩',
                            Somaliland: '荷属圣马丁',
                            Djibouti: '吉布提',
                            Eritrea: '厄立特里亚',
                            Burundi: '布隆迪',
                            Senegal: '塞内加尔',
                            Guinea: '几内亚',
                            Zimbabwe: '津巴布韦',
                            Paraguay: '巴拉圭',
                            Belarus: '白俄罗斯',
                            Latvia: '拉脱维亚',
                            Bhutan: '不丹',
                            Namibia: '纳米比亚',
                            'Burkina Faso': '布基纳法索',
                            'South Sudan': '南苏丹',
                            'Central African Republic': '中非',
                            Moldova: '摩尔多瓦',
                            Kenya: '肯尼亚',
                            Botswana: '博茨瓦纳',
                            'Czech Republic': '捷克',
                            'Puerto Rico': '波多黎各',
                            Tunisia: '突尼斯',
                            Cuba: '古巴',
                            Vietnam: '越南',
                            Madagascar: '马达加斯加',
                            Venezuela: '委内瑞拉',
                            Iceland: '冰岛',
                            Nepal: '尼泊尔',
                            Suriname: '苏里南',
                            Kyrgyzstan: '吉尔吉斯斯坦'
                        }
                    }
                ]
            };
            myChart.setOption(option);
        }
    );
    return option;
}

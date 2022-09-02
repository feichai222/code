# 建表语句

描述表结构的建表语句应当按照蓝鲸平台 hive 中库和表从属关系进行安排, 例如:
```
hive
├── README.md
├── dw_adplatform
│   ├── dev_ad_data_applovin.hql
│   ├── dev_ad_data_appsflyer.hql
│   └── dev_ad_data_vungle.hql
└── dw_vigoo
    ├── dw_ad_data_apus_adsense.hql
    └── dw_ad_data_gamedistribution.hql
```

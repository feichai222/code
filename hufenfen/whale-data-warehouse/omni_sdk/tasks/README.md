# 调度任务

调度任务应当按照蓝鲸平台调度任务的从属关系进行安排, 例如:

```
tasks
├── README.md
├── vigoo(bj_vigoo)
│   └── 定时任务
│       └── vigoo广告清洗(抓取数据)
│           ├── vigoo_apus_ad_data
│           │   ├── vigoo_apus_ad_data.hql
│           │   └── vigoo_apus_ad_data.md
│           ├── vigoo_botim_ad_data
│           │   ├── vigoo_botim_ad_data.hql
│           │   └── vigoo_botim_ad_data.md
│           └── vigoo_xender3_ad_data
│               ├── vigoo_xender3_ad_data.hql
│               └── vigoo_xender3_ad_data.md
└── 北京海外项目(bj_adplatform)
    └── 定时任务
        ├── 【全产品】广告平台调度
        │   └── dm_adplatform_addata
        │       ├── dm_adplatform_addata.hql
        │       └── dm_adplatform_addata.md
        └── 【开发环境】广告平台原始数据
            ├── dev_ad_data_adcolony
            │   ├── dev_ad_data_adcolony.hql
            │   └── dev_ad_data_adcolony.md
            ├── dev_ad_data_admob
            │   ├── dev_ad_data_admob.hql
            │   └── dev_ad_data_admob.md
            ├── dev_ad_data_transsion_adsense
            │   ├── dev_ad_data_transsion_adsense.hql
            │   └── dev_ad_data_transsion_adsense.md
            └── dev_ad_data_vungle
                ├── dev_ad_data_vungle.hql
                └── dev_ad_data_vungle.md
```

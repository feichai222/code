# 数仓结构说明

*   [表](#表)

    *   [ODS 层](#ODS)
        *   [OmniSDK 上报事件表 ( dw_omni_sdk.ods_omni_sdk_event_di )](#dw-omni-sdk-ods-omni-sdk-event-di)
        *   [OmniSDK上报的事件新表 ( dw_omni_sdk.ods_omni_sdk_event_rt )](#dw-omni-sdk-ods-omni-sdk-event-rt)
        *   [泡泡 IOS 明细表 ( dw_omni_sdk.ods_paopao_ffbe_ios_payment )](#dw-omni-sdk-ods-paopao-ffbe-ios-payment)
        *   [ad-data-scraper数据源 ( dw_omni_sdk.ods_app_store_filebeat_rt )](#dw-omni-sdk-ods-app-store-filebeat-rt)

    *   [DWD 层](#DWD)
        *   [app store 销售数据日汇总数据表 ( dw_omni_sdk.dwd_app_store_sales_summary_daily_report_di )](#dw-omni-sdk-dwd-app-store-sales-summary-daily-report-di)
        *   [苹果商店外币各档位转换人民币维度表 ( dw_omni_sdk.dwd_dim_app_store_cny_currency_transform_da )](#dw-omni-sdk-dwd-dim-app-store-cny-currency-transform-da)
        *   [app store 游戏维表 ( dw_omni_sdk.dwd_dim_app_store_game_name_di )](#dw-omni-sdk-dwd-dim-app-store-game-name-di)
        *   [OmniSDK-api-access事实表 ( dw_omni_sdk.dwd_fact_omni_sdk_api_di )](#dw-omni-sdk-dwd-fact-omni-sdk-api-di)
        *   [OmniSDK登录事实表 ( dw_omni_sdk.dwd_fact_omni_sdk_login_di )](#dw-omni-sdk-dwd-fact-omni-sdk-login-di)
        *   [OmniSDK订单完成事实表 ( dw_omni_sdk.dwd_fact_omni_sdk_order_complete_di )](#dw-omni-sdk-dwd-fact-omni-sdk-order-complete-di)
        *   [ OmniSDK 订单创建事实表 ( dw_omni_sdk.dwd_fact_omni_sdk_order_create_di )](#dw-omni-sdk-dwd-fact-omni-sdk-order-create-di)

    *   [DWB 层](#DWB)
        *   [OmniSDK-login 用户明细事实表 ( dm_omni_sdk.dwb_fact_omni_sdk_active_user_di )](#dm-omni-sdk-dwb-fact-omni-sdk-active-user-di)
        *   [OmniSDK-api 明细数据表 ( dm_omni_sdk.dwb_fact_omni_sdk_api_di )](#dm-omni-sdk-dwb-fact-omni-sdk-api-di)
        *   [OmniSDK订单明细事实表 ( dm_omni_sdk.dwb_fact_omni_sdk_order_detail_di )](#dm-omni-sdk-dwb-fact-omni-sdk-order-detail-di)

    *   [DWS 层](#DWS)
        *   [app store 销售数据日轻度汇总表 ( dm_omni_sdk.dws_app_store_sales_summary_daily_report_di )](#dm-omni-sdk-dws-app-store-sales-summary-daily-report-di)
        *   [OmniSDK 用户轻度汇总数据表 ( dm_omni_sdk.dws_omni_sdk_active_user_di )](#dm-omni-sdk-dws-omni-sdk-active-user-di)
        *   [OmniSDK-api统计数据表 ( dm_omni_sdk.dws_omni_sdk_api_di )](#dm-omni-sdk-dws-omni-sdk-api-di)
        *   [OmniSDK设备统计数据表 ( dm_omni_sdk.dws_omni_sdk_device_di )](#dm-omni-sdk-dws-omni-sdk-device-di)
        *   [OmniSDK活跃UID统计数据表 ( dm_omni_sdk.dws_omni_sdk_uid_di )](#dm-omni-sdk-dws-omni-sdk-uid-di)

    *   [DWT 层](#DWT)
        *   [ OmniSDK 订单主题汇总表 ( dm_omni_sdk.dwt_omni_sdk_order_amount_di )](#dm-omni-sdk-dwt-omni-sdk-order-amount-di)

    *   [DIM 层](#DIM)
        *   [app store 价格换算维表 ( dm_omni_sdk.dim_app_store_pricing_matrix )](#dm-omni-sdk-dim-app-store-pricing-matrix)
        *   [app store 区域及货币维表 ( dm_omni_sdk.dim_currency )](#dm-omni-sdk-dim-currency)
        *   [app store 产品类型维表 ( dm_omni_sdk.dim_product_type )](#dm-omni-sdk-dim-product-type)
        *   [app store 区域维表 ( dm_omni_sdk.dim_region )](#dm-omni-sdk-dim-region)
        *   [国家代码维度表 ( dm_omni_sdk.dim_wiki_country_code )](#dm-omni-sdk-dim-wiki-country-code)

    *   [ADS 层](#ADS)
        *   [OmniSDK api维度对照配置表 ( dm_omni_sdk.ads_conf_omni_sdk_api_dimension )](#dm-omni-sdk-ads-conf-omni-sdk-api-dimension)
        *   [OmniSDK应用属性配置表 ( dm_omni_sdk.ads_conf_omni_sdk_app_di )](#dm-omni-sdk-ads-conf-omni-sdk-app-di)
        *   [OmniSDK设备维度对照配置表 ( dm_omni_sdk.ads_conf_omni_sdk_device_dimension )](#dm-omni-sdk-ads-conf-omni-sdk-device-dimension)
        *   [OmniSDK账号维度对照配置表 ( dm_omni_sdk.ads_conf_omni_sdk_uid_dimension )](#dm-omni-sdk-ads-conf-omni-sdk-uid-dimension)
        *   [OmniSDK api可用维度表 ( dm_omni_sdk.ads_omni_sdk_api_dimension_di )](#dm-omni-sdk-ads-omni-sdk-api-dimension-di)
        *   [OmniSDK设备可用维度表 ( dm_omni_sdk.ads_omni_sdk_device_dimension_di )](#dm-omni-sdk-ads-omni-sdk-device-dimension-di)
        *   [OmniSDK账号可用维度表 ( dm_omni_sdk.ads_omni_sdk_uid_dimension_di )](#dm-omni-sdk-ads-omni-sdk-uid-dimension-di)
    *   [其他](#其他)
        *   [开发环境OmniSDK上报的原始数据 ( dw_omni_sdk.dev_raw_omni_sdk_event )](#dw-omni-sdk-dev-raw-omni-sdk-event)
        *   [dev-ad-data-scraper数据源 ( dw_omni_sdk.raw_dev_ad_data_scraper_filebeat )](#dw-omni-sdk-raw-dev-ad-data-scraper-filebeat)
        *   [OmniSDK上报的原始数据 ( dw_omni_sdk.raw_omni_sdk_event )](#dw-omni-sdk-raw-omni-sdk-event)
        *   [AWS账单数据 ( dw_omni_sdk.raw_tmp_aws_billing )](#dw-omni-sdk-raw-tmp-aws-billing)
        *   [filebeat上报的账单数据 ( dw_omni_sdk.raw_tmp_aws_billing_filebeat_num )](#dw-omni-sdk-raw-tmp-aws-billing-filebeat-num)

# 表

## ODS 层



### OmniSDK 上报事件表 ( dw_omni_sdk.ods_omni_sdk_event_di ) <a name="dw-omni-sdk-ods-omni-sdk-event-di"></a>
*   描述文档: [ods_omni_sdk_event_di.md](dw_omni_sdk/ods_omni_sdk_event_di.md)

*   建表语句: [ods_omni_sdk_event_di.sql](../../hive/dw_omni_sdk/ods_omni_sdk_event_di.sql)

*   数据来源: [OmniSDK上报的原始数据 ( dw_omni_sdk.raw_omni_sdk_event )](#dw-omni-sdk-raw-omni-sdk-event)

*   全量更新: [ods_omni_sdk_event_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ods/ods_omni_sdk_event_di/ods_omni_sdk_event_di.all.sql)

*   增量更新: [ods_omni_sdk_event_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ods/ods_omni_sdk_event_di/ods_omni_sdk_event_di.inc.sql)

### OmniSDK上报的事件新表 ( dw_omni_sdk.ods_omni_sdk_event_rt ) <a name="dw-omni-sdk-ods-omni-sdk-event-rt"></a>
*   描述文档: [ods_omni_sdk_event_rt.md](dw_omni_sdk/ods_omni_sdk_event_rt.md)

*   建表语句: [ods_omni_sdk_event_rt.sql](../../hive/dw_omni_sdk/ods_omni_sdk_event_rt.sql)

*   数据来源: [OmniSDK上报的原始数据 ( dw_omni_sdk.raw_omni_sdk_event )](#dw-omni-sdk-raw-omni-sdk-event)

*   全量更新: [ods_omni_sdk_event_rt.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ods/ods_omni_sdk_event_rt/ods_omni_sdk_event_rt.all.sql)

*   增量更新: [ods_omni_sdk_event_rt.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ods/ods_omni_sdk_event_rt/ods_omni_sdk_event_rt.inc.sql)

### 泡泡 IOS 明细表 ( dw_omni_sdk.ods_paopao_ffbe_ios_payment ) <a name="dw-omni-sdk-ods-paopao-ffbe-ios-payment"></a>
*   描述文档: [ods_paopao_ffbe_ios_payment.md](dw_omni_sdk/ods_paopao_ffbe_ios_payment.md)

*   建表语句: [ods_paopao_ffbe_ios_payment.sql](../../hive/dw_omni_sdk/ods_paopao_ffbe_ios_payment.sql)

*   全量更新: [ods_paopao_ffbe_ios_payment.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ods/ods_paopao_ffbe_ios_payment/ods_paopao_ffbe_ios_payment.all.sql)

*   增量更新: [ods_paopao_ffbe_ios_payment.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ods/ods_paopao_ffbe_ios_payment/ods_paopao_ffbe_ios_payment.inc.sql)

### ad-data-scraper数据源 ( dw_omni_sdk.ods_app_store_filebeat_rt ) <a name="dw-omni-sdk-ods-app-store-filebeat-rt"></a>
*   描述文档: [ods_app_store_filebeat_rt.md](dw_omni_sdk/ods_app_store_filebeat_rt.md)

*   建表语句: [ods_app_store_filebeat_rt.sql](../../hive/dw_omni_sdk/ods_app_store_filebeat_rt.sql)

*   全量更新: [ods_app_store_filebeat_rt.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ods/ods_app_store_filebeat_rt/ods_app_store_filebeat_rt.all.sql)

*   增量更新: [ods_app_store_filebeat_rt.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ods/ods_app_store_filebeat_rt/ods_app_store_filebeat_rt.inc.sql)


## DWD 层



### app store 销售数据日汇总数据表 ( dw_omni_sdk.dwd_app_store_sales_summary_daily_report_di ) <a name="dw-omni-sdk-dwd-app-store-sales-summary-daily-report-di"></a>
*   描述文档: [dwd_app_store_sales_summary_daily_report_di.md](dw_omni_sdk/dwd_app_store_sales_summary_daily_report_di.md)

*   建表语句: [dwd_app_store_sales_summary_daily_report_di.sql](../../hive/dw_omni_sdk/dwd_app_store_sales_summary_daily_report_di.sql)

*   全量更新: [dwd_app_store_sales_summary_daily_report_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_app_store_sales_summary_daily_report_di/dwd_app_store_sales_summary_daily_report_di.all.sql)

*   增量更新: [dwd_app_store_sales_summary_daily_report_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_app_store_sales_summary_daily_report_di/dwd_app_store_sales_summary_daily_report_di.inc.sql)

### 苹果商店外币各档位转换人民币维度表 ( dw_omni_sdk.dwd_dim_app_store_cny_currency_transform_da ) <a name="dw-omni-sdk-dwd-dim-app-store-cny-currency-transform-da"></a>
*   描述文档: [dwd_dim_app_store_cny_currency_transform_da.md](dw_omni_sdk/dwd_dim_app_store_cny_currency_transform_da.md)

*   建表语句: [dwd_dim_app_store_cny_currency_transform_da.sql](../../hive/dw_omni_sdk/dwd_dim_app_store_cny_currency_transform_da.sql)

*   全量更新: [dwd_dim_app_store_cny_currency_transform_da.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_dim_app_store_cny_currency_transform_da/dwd_dim_app_store_cny_currency_transform_da.all.sql)

*   增量更新: [dwd_dim_app_store_cny_currency_transform_da.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_dim_app_store_cny_currency_transform_da/dwd_dim_app_store_cny_currency_transform_da.inc.sql)

### app store 游戏维表 ( dw_omni_sdk.dwd_dim_app_store_game_name_di ) <a name="dw-omni-sdk-dwd-dim-app-store-game-name-di"></a>
*   描述文档: [dwd_dim_app_store_game_name_di.md](dw_omni_sdk/dwd_dim_app_store_game_name_di.md)

*   建表语句: [dwd_dim_app_store_game_name_di.sql](../../hive/dw_omni_sdk/dwd_dim_app_store_game_name_di.sql)

*   全量更新: [dwd_dim_app_store_game_name_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_dim_app_store_game_name_di/dwd_dim_app_store_game_name_di.all.sql)

*   增量更新: [dwd_dim_app_store_game_name_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_dim_app_store_game_name_di/dwd_dim_app_store_game_name_di.inc.sql)

### OmniSDK-api-access事实表 ( dw_omni_sdk.dwd_fact_omni_sdk_api_di ) <a name="dw-omni-sdk-dwd-fact-omni-sdk-api-di"></a>
*   描述文档: [dwd_fact_omni_sdk_api_di.md](dw_omni_sdk/dwd_fact_omni_sdk_api_di.md)

*   建表语句: [dwd_fact_omni_sdk_api_di.sql](../../hive/dw_omni_sdk/dwd_fact_omni_sdk_api_di.sql)

*   数据来源: [OmniSDK 上报事件表 ( dw_omni_sdk.ods_omni_sdk_event_di )](#dw-omni-sdk-ods-omni-sdk-event-di)

*   全量更新: [dwd_fact_omni_sdk_api_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_fact_omni_sdk_api_di/dwd_fact_omni_sdk_api_di.all.sql)

*   增量更新: [dwd_fact_omni_sdk_api_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_fact_omni_sdk_api_di/dwd_fact_omni_sdk_api_di.inc.sql)

### OmniSDK登录事实表 ( dw_omni_sdk.dwd_fact_omni_sdk_login_di ) <a name="dw-omni-sdk-dwd-fact-omni-sdk-login-di"></a>
*   描述文档: [dwd_fact_omni_sdk_login_di.md](dw_omni_sdk/dwd_fact_omni_sdk_login_di.md)

*   建表语句: [dwd_fact_omni_sdk_login_di.sql](../../hive/dw_omni_sdk/dwd_fact_omni_sdk_login_di.sql)

*   数据来源: [OmniSDK 上报事件表 ( dw_omni_sdk.ods_omni_sdk_event_di )](#dw-omni-sdk-ods-omni-sdk-event-di)

*   全量更新: [dwd_fact_omni_sdk_login_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_fact_omni_sdk_login_di/dwd_fact_omni_sdk_login_di.all.sql)

*   增量更新: [dwd_fact_omni_sdk_login_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_fact_omni_sdk_login_di/dwd_fact_omni_sdk_login_di.inc.sql)

### OmniSDK订单完成事实表 ( dw_omni_sdk.dwd_fact_omni_sdk_order_complete_di ) <a name="dw-omni-sdk-dwd-fact-omni-sdk-order-complete-di"></a>
*   描述文档: [dwd_fact_omni_sdk_order_complete_di.md](dw_omni_sdk/dwd_fact_omni_sdk_order_complete_di.md)

*   建表语句: [dwd_fact_omni_sdk_order_complete_di.sql](../../hive/dw_omni_sdk/dwd_fact_omni_sdk_order_complete_di.sql)

*   数据来源: [OmniSDK 上报事件表 ( dw_omni_sdk.ods_omni_sdk_event_di )](#dw-omni-sdk-ods-omni-sdk-event-di)

*   全量更新: [dwd_fact_omni_sdk_order_complete_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_fact_omni_sdk_order_complete_di/dwd_fact_omni_sdk_order_complete_di.all.sql)

*   增量更新: [dwd_fact_omni_sdk_order_complete_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_fact_omni_sdk_order_complete_di/dwd_fact_omni_sdk_order_complete_di.inc.sql)

###  OmniSDK 订单创建事实表 ( dw_omni_sdk.dwd_fact_omni_sdk_order_create_di ) <a name="dw-omni-sdk-dwd-fact-omni-sdk-order-create-di"></a>
*   描述文档: [dwd_fact_omni_sdk_order_create_di.md](dw_omni_sdk/dwd_fact_omni_sdk_order_create_di.md)

*   建表语句: [dwd_fact_omni_sdk_order_create_di.sql](../../hive/dw_omni_sdk/dwd_fact_omni_sdk_order_create_di.sql)

*   数据来源: [OmniSDK 上报事件表 ( dw_omni_sdk.ods_omni_sdk_event_di )](#dw-omni-sdk-ods-omni-sdk-event-di)

*   全量更新: [dwd_fact_omni_sdk_order_create_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_fact_omni_sdk_order_create_di/dwd_fact_omni_sdk_order_create_di.all.sql)

*   增量更新: [dwd_fact_omni_sdk_order_create_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwd/dwd_fact_omni_sdk_order_create_di/dwd_fact_omni_sdk_order_create_di.inc.sql)


## DWB 层


### OmniSDK-login 用户明细事实表 ( dm_omni_sdk.dwb_fact_omni_sdk_active_user_di ) <a name="dm-omni-sdk-dwb-fact-omni-sdk-active-user-di"></a>
*   描述文档: [dwb_fact_omni_sdk_active_user_di.md](dm_omni_sdk/dwb_fact_omni_sdk_active_user_di.md)

*   建表语句: [dwb_fact_omni_sdk_active_user_di.sql](../../hive/dm_omni_sdk/dwb_fact_omni_sdk_active_user_di.sql)

*   全量更新: [dwb_fact_omni_sdk_active_user_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwb/dwb_fact_omni_sdk_active_user_di/dwb_fact_omni_sdk_active_user_di.all.sql)

*   增量更新: [dwb_fact_omni_sdk_active_user_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwb/dwb_fact_omni_sdk_active_user_di/dwb_fact_omni_sdk_active_user_di.inc.sql)

### OmniSDK-api 明细数据表 ( dm_omni_sdk.dwb_fact_omni_sdk_api_di ) <a name="dm-omni-sdk-dwb-fact-omni-sdk-api-di"></a>
*   描述文档: [dwb_fact_omni_sdk_api_di.md](dm_omni_sdk/dwb_fact_omni_sdk_api_di.md)

*   建表语句: [dwb_fact_omni_sdk_api_di.sql](../../hive/dm_omni_sdk/dwb_fact_omni_sdk_api_di.sql)

*   全量更新: [dwb_fact_omni_sdk_api_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwb/dwb_fact_omni_sdk_api_di/dwb_fact_omni_sdk_api_di.all.sql)

*   增量更新: [dwb_fact_omni_sdk_api_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwb/dwb_fact_omni_sdk_api_di/dwb_fact_omni_sdk_api_di.inc.sql)

### OmniSDK订单明细事实表 ( dm_omni_sdk.dwb_fact_omni_sdk_order_detail_di ) <a name="dm-omni-sdk-dwb-fact-omni-sdk-order-detail-di"></a>
*   描述文档: [dwb_fact_omni_sdk_order_detail_di.md](dm_omni_sdk/dwb_fact_omni_sdk_order_detail_di.md)

*   建表语句: [dwb_fact_omni_sdk_order_detail_di.sql](../../hive/dm_omni_sdk/dwb_fact_omni_sdk_order_detail_di.sql)

*   全量更新: [dwb_fact_omni_sdk_order_detail_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwb/dwb_fact_omni_sdk_order_detail_di/dwb_fact_omni_sdk_order_detail_di.all.sql)

*   增量更新: [dwb_fact_omni_sdk_order_detail_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwb/dwb_fact_omni_sdk_order_detail_di/dwb_fact_omni_sdk_order_detail_di.inc.sql)

*   计算规则: [readme.md](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwb/dwb_fact_omni_sdk_order_detail_di/readme.md)



## DWS 层


### app store 销售数据日轻度汇总表 ( dm_omni_sdk.dws_app_store_sales_summary_daily_report_di ) <a name="dm-omni-sdk-dws-app-store-sales-summary-daily-report-di"></a>
*   描述文档: [dws_app_store_sales_summary_daily_report_di.md](dm_omni_sdk/dws_app_store_sales_summary_daily_report_di.md)

*   建表语句: [dws_app_store_sales_summary_daily_report_di.sql](../../hive/dm_omni_sdk/dws_app_store_sales_summary_daily_report_di.sql)

*   全量更新: [dws_app_store_sales_summary_daily_report_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_app_store_sales_summary_daily_report_di/dws_app_store_sales_summary_daily_report_di.all.sql)

*   增量更新: [dws_app_store_sales_summary_daily_report_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_app_store_sales_summary_daily_report_di/dws_app_store_sales_summary_daily_report_di.inc.sql)

### OmniSDK 用户轻度汇总数据表 ( dm_omni_sdk.dws_omni_sdk_active_user_di ) <a name="dm-omni-sdk-dws-omni-sdk-active-user-di"></a>
*   描述文档: [dws_omni_sdk_active_user_di.md](dm_omni_sdk/dws_omni_sdk_active_user_di.md)

*   建表语句: [dws_omni_sdk_active_user_di.sql](../../hive/dm_omni_sdk/dws_omni_sdk_active_user_di.sql)

*   全量更新: [dws_omni_sdk_active_user_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_omni_sdk_active_user_di/dws_omni_sdk_active_user_di.all.sql)

*   增量更新: [dws_omni_sdk_active_user_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_omni_sdk_active_user_di/dws_omni_sdk_active_user_di.inc.sql)

### OmniSDK-api统计数据表 ( dm_omni_sdk.dws_omni_sdk_api_di ) <a name="dm-omni-sdk-dws-omni-sdk-api-di"></a>
*   描述文档: [dws_omni_sdk_api_di.md](dm_omni_sdk/dws_omni_sdk_api_di.md)

*   建表语句: [dws_omni_sdk_api_di.sql](../../hive/dm_omni_sdk/dws_omni_sdk_api_di.sql)

*   全量更新: [dws_omni_sdk_api_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_omni_sdk_api_di/dws_omni_sdk_api_di.all.sql)

*   增量更新: [dws_omni_sdk_api_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_omni_sdk_api_di/dws_omni_sdk_api_di.inc.sql)

### OmniSDK设备统计数据表 ( dm_omni_sdk.dws_omni_sdk_device_di ) <a name="dm-omni-sdk-dws-omni-sdk-device-di"></a>
*   描述文档: [dws_omni_sdk_device_di.md](dm_omni_sdk/dws_omni_sdk_device_di.md)

*   建表语句: [dws_omni_sdk_device_di.sql](../../hive/dm_omni_sdk/dws_omni_sdk_device_di.sql)

*   全量更新: [dws_omni_sdk_device_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_omni_sdk_device_di/dws_omni_sdk_device_di.all.sql)

*   增量更新: [dws_omni_sdk_device_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_omni_sdk_device_di/dws_omni_sdk_device_di.inc.sql)

### OmniSDK活跃UID统计数据表 ( dm_omni_sdk.dws_omni_sdk_uid_di ) <a name="dm-omni-sdk-dws-omni-sdk-uid-di"></a>
*   描述文档: [dws_omni_sdk_uid_di.md](dm_omni_sdk/dws_omni_sdk_uid_di.md)

*   建表语句: [dws_omni_sdk_uid_di.sql](../../hive/dm_omni_sdk/dws_omni_sdk_uid_di.sql)

*   全量更新: [dws_omni_sdk_uid_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_omni_sdk_uid_di/dws_omni_sdk_uid_di.all.sql)

*   增量更新: [dws_omni_sdk_uid_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dws/dws_omni_sdk_uid_di/dws_omni_sdk_uid_di.inc.sql)



## DWT 层


###  OmniSDK 订单主题汇总表 ( dm_omni_sdk.dwt_omni_sdk_order_amount_di ) <a name="dm-omni-sdk-dwt-omni-sdk-order-amount-di"></a>
*   描述文档: [dwt_omni_sdk_order_amount_di.md](dm_omni_sdk/dwt_omni_sdk_order_amount_di.md)

*   建表语句: [dwt_omni_sdk_order_amount_di.sql](../../hive/dm_omni_sdk/dwt_omni_sdk_order_amount_di.sql)

*   全量更新: [dwt_omni_sdk_order_amount_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwt/dwt_omni_sdk_order_amount_di/dwt_omni_sdk_order_amount_di.all.sql)

*   增量更新: [dwt_omni_sdk_order_amount_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dwt/dwt_omni_sdk_order_amount_di/dwt_omni_sdk_order_amount_di.inc.sql)



## DIM 层


### app store 价格换算维表 ( dm_omni_sdk.dim_app_store_pricing_matrix ) <a name="dm-omni-sdk-dim-app-store-pricing-matrix"></a>
*   描述文档: [dim_app_store_pricing_matrix.md](dm_omni_sdk/dim_app_store_pricing_matrix.md)

*   建表语句: [dim_app_store_pricing_matrix.sql](../../hive/dm_omni_sdk/dim_app_store_pricing_matrix.sql)

*   全量更新: [dim_app_store_pricing_matrix.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_app_store_pricing_matrix/dim_app_store_pricing_matrix.all.sql)

*   增量更新: [dim_app_store_pricing_matrix.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_app_store_pricing_matrix/dim_app_store_pricing_matrix.inc.sql)

### app store 区域及货币维表 ( dm_omni_sdk.dim_currency ) <a name="dm-omni-sdk-dim-currency"></a>
*   描述文档: [dim_currency.md](dm_omni_sdk/dim_currency.md)

*   建表语句: [dim_currency.sql](../../hive/dm_omni_sdk/dim_currency.sql)

*   全量更新: [dim_currency.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_currency/dim_currency.all.sql)

*   增量更新: [dim_currency.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_currency/dim_currency.inc.sql)

### app store 产品类型维表 ( dm_omni_sdk.dim_product_type ) <a name="dm-omni-sdk-dim-product-type"></a>
*   描述文档: [dim_product_type.md](dm_omni_sdk/dim_product_type.md)

*   建表语句: [dim_product_type.sql](../../hive/dm_omni_sdk/dim_product_type.sql)

*   全量更新: [dim_product_type.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_product_type/dim_product_type.all.sql)

*   增量更新: [dim_product_type.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_product_type/dim_product_type.inc.sql)

### app store 区域维表 ( dm_omni_sdk.dim_region ) <a name="dm-omni-sdk-dim-region"></a>
*   描述文档: [dim_region.md](dm_omni_sdk/dim_region.md)

*   建表语句: [dim_region.sql](../../hive/dm_omni_sdk/dim_region.sql)

*   全量更新: [dim_region.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_region/dim_region.all.sql)

*   增量更新: [dim_region.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_region/dim_region.inc.sql)

### 国家代码维度表 ( dm_omni_sdk.dim_wiki_country_code ) <a name="dm-omni-sdk-dim-wiki-country-code"></a>
*   描述文档: [dim_wiki_country_code.md](dm_omni_sdk/dim_wiki_country_code.md)

*   建表语句: [dim_wiki_country_code.sql](../../hive/dm_omni_sdk/dim_wiki_country_code.sql)

*   全量更新: [dim_wiki_country_code.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_wiki_country_code/dim_wiki_country_code.all.sql)

*   增量更新: [dim_wiki_country_code.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/dim/dim_wiki_country_code/dim_wiki_country_code.inc.sql)



## ADS 层


### OmniSDK api维度对照配置表 ( dm_omni_sdk.ads_conf_omni_sdk_api_dimension ) <a name="dm-omni-sdk-ads-conf-omni-sdk-api-dimension"></a>
*   描述文档: [ads_conf_omni_sdk_api_dimension.md](dm_omni_sdk/ads_conf_omni_sdk_api_dimension.md)

*   建表语句: [ads_conf_omni_sdk_api_dimension.sql](../../hive/dm_omni_sdk/ads_conf_omni_sdk_api_dimension.sql)

*   全量更新: [ads_conf_omni_sdk_api_dimension.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_conf_omni_sdk_api_dimension/ads_conf_omni_sdk_api_dimension.all.sql)

*   增量更新: [ads_conf_omni_sdk_api_dimension.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_conf_omni_sdk_api_dimension/ads_conf_omni_sdk_api_dimension.inc.sql)

### OmniSDK应用属性配置表 ( dm_omni_sdk.ads_conf_omni_sdk_app_di ) <a name="dm-omni-sdk-ads-conf-omni-sdk-app-di"></a>
*   描述文档: [ads_conf_omni_sdk_app_di.md](dm_omni_sdk/ads_conf_omni_sdk_app_di.md)

*   建表语句: [ads_conf_omni_sdk_app_di.sql](../../hive/dm_omni_sdk/ads_conf_omni_sdk_app_di.sql)

*   全量更新: [ads_conf_omni_sdk_app_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_conf_omni_sdk_app_di/ads_conf_omni_sdk_app_di.all.sql)

*   增量更新: [ads_conf_omni_sdk_app_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_conf_omni_sdk_app_di/ads_conf_omni_sdk_app_di.inc.sql)

### OmniSDK设备维度对照配置表 ( dm_omni_sdk.ads_conf_omni_sdk_device_dimension ) <a name="dm-omni-sdk-ads-conf-omni-sdk-device-dimension"></a>
*   描述文档: [ads_conf_omni_sdk_device_dimension.md](dm_omni_sdk/ads_conf_omni_sdk_device_dimension.md)

*   建表语句: [ads_conf_omni_sdk_device_dimension.sql](../../hive/dm_omni_sdk/ads_conf_omni_sdk_device_dimension.sql)

*   全量更新: [ads_conf_omni_sdk_device_dimension.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_conf_omni_sdk_device_dimension/ads_conf_omni_sdk_device_dimension.all.sql)

*   增量更新: [ads_conf_omni_sdk_device_dimension.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_conf_omni_sdk_device_dimension/ads_conf_omni_sdk_device_dimension.inc.sql)

### OmniSDK账号维度对照配置表 ( dm_omni_sdk.ads_conf_omni_sdk_uid_dimension ) <a name="dm-omni-sdk-ads-conf-omni-sdk-uid-dimension"></a>
*   描述文档: [ads_conf_omni_sdk_uid_dimension.md](dm_omni_sdk/ads_conf_omni_sdk_uid_dimension.md)

*   建表语句: [ads_conf_omni_sdk_uid_dimension.sql](../../hive/dm_omni_sdk/ads_conf_omni_sdk_uid_dimension.sql)

*   全量更新: [ads_conf_omni_sdk_uid_dimension.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_conf_omni_sdk_uid_dimension/ads_conf_omni_sdk_uid_dimension.all.sql)

*   增量更新: [ads_conf_omni_sdk_uid_dimension.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_conf_omni_sdk_uid_dimension/ads_conf_omni_sdk_uid_dimension.inc.sql)

### OmniSDK api可用维度表 ( dm_omni_sdk.ads_omni_sdk_api_dimension_di ) <a name="dm-omni-sdk-ads-omni-sdk-api-dimension-di"></a>
*   描述文档: [ads_omni_sdk_api_dimension_di.md](dm_omni_sdk/ads_omni_sdk_api_dimension_di.md)

*   建表语句: [ads_omni_sdk_api_dimension_di.sql](../../hive/dm_omni_sdk/ads_omni_sdk_api_dimension_di.sql)

*   全量更新: [ads_omni_sdk_api_dimension_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_omni_sdk_api_dimension_di/ads_omni_sdk_api_dimension_di.all.sql)

*   增量更新: [ads_omni_sdk_api_dimension_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_omni_sdk_api_dimension_di/ads_omni_sdk_api_dimension_di.inc.sql)

### OmniSDK设备可用维度表 ( dm_omni_sdk.ads_omni_sdk_device_dimension_di ) <a name="dm-omni-sdk-ads-omni-sdk-device-dimension-di"></a>
*   描述文档: [ads_omni_sdk_device_dimension_di.md](dm_omni_sdk/ads_omni_sdk_device_dimension_di.md)

*   建表语句: [ads_omni_sdk_device_dimension_di.sql](../../hive/dm_omni_sdk/ads_omni_sdk_device_dimension_di.sql)

*   全量更新: [ads_omni_sdk_device_dimension_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_omni_sdk_device_dimension_di/ads_omni_sdk_device_dimension_di.all.sql)

*   增量更新: [ads_omni_sdk_device_dimension_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_omni_sdk_device_dimension_di/ads_omni_sdk_device_dimension_di.inc.sql)

### OmniSDK账号可用维度表 ( dm_omni_sdk.ads_omni_sdk_uid_dimension_di ) <a name="dm-omni-sdk-ads-omni-sdk-uid-dimension-di"></a>
*   描述文档: [ads_omni_sdk_uid_dimension_di.md](dm_omni_sdk/ads_omni_sdk_uid_dimension_di.md)

*   建表语句: [ads_omni_sdk_uid_dimension_di.sql](../../hive/dm_omni_sdk/ads_omni_sdk_uid_dimension_di.sql)

*   全量更新: [ads_omni_sdk_uid_dimension_di.all.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_omni_sdk_uid_dimension_di/ads_omni_sdk_uid_dimension_di.all.sql)

*   增量更新: [ads_omni_sdk_uid_dimension_di.inc.sql](../../tasks/北京海外SDK(bj_omni_sdk)/定时任务/分层调度/ads/ads_omni_sdk_uid_dimension_di/ads_omni_sdk_uid_dimension_di.inc.sql)



## 其他



### 开发环境OmniSDK上报的原始数据 ( dw_omni_sdk.dev_raw_omni_sdk_event ) <a name="dw-omni-sdk-dev-raw-omni-sdk-event"></a>
*   描述文档: [dev_raw_omni_sdk_event.md](dw_omni_sdk/dev_raw_omni_sdk_event.md)

*   建表语句: [dev_raw_omni_sdk_event.sql](../../hive/dw_omni_sdk/dev_raw_omni_sdk_event.sql)

### dev-ad-data-scraper数据源 ( dw_omni_sdk.raw_dev_ad_data_scraper_filebeat ) <a name="dw-omni-sdk-raw-dev-ad-data-scraper-filebeat"></a>
*   描述文档: [raw_dev_ad_data_scraper_filebeat.md](dw_omni_sdk/raw_dev_ad_data_scraper_filebeat.md)

*   建表语句: [raw_dev_ad_data_scraper_filebeat.sql](../../hive/dw_omni_sdk/raw_dev_ad_data_scraper_filebeat.sql)

### OmniSDK上报的原始数据 ( dw_omni_sdk.raw_omni_sdk_event ) <a name="dw-omni-sdk-raw-omni-sdk-event"></a>
*   描述文档: [raw_omni_sdk_event.md](dw_omni_sdk/raw_omni_sdk_event.md)

*   建表语句: [raw_omni_sdk_event.sql](../../hive/dw_omni_sdk/raw_omni_sdk_event.sql)

### AWS账单数据 ( dw_omni_sdk.raw_tmp_aws_billing ) <a name="dw-omni-sdk-raw-tmp-aws-billing"></a>
*   描述文档: [raw_tmp_aws_billing.md](dw_omni_sdk/raw_tmp_aws_billing.md)

*   建表语句: [raw_tmp_aws_billing.sql](../../hive/dw_omni_sdk/raw_tmp_aws_billing.sql)

### filebeat上报的账单数据 ( dw_omni_sdk.raw_tmp_aws_billing_filebeat_num ) <a name="dw-omni-sdk-raw-tmp-aws-billing-filebeat-num"></a>
*   描述文档: [raw_tmp_aws_billing_filebeat_num.md](dw_omni_sdk/raw_tmp_aws_billing_filebeat_num.md)

*   建表语句: [raw_tmp_aws_billing_filebeat_num.sql](../../hive/dw_omni_sdk/raw_tmp_aws_billing_filebeat_num.sql)

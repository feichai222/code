-- 任务名: ads_omni_sdk_api_dimension_di
-- 作者: 翟旭亮
-- 功能: 聚合 dws_omni_sdk_api_di 表将维度提取出来
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions.pernode = 400;
SET hive.exec.max.dynamic.partitions = 400;
INSERT OVERWRITE TABLE dm_omni_sdk.ads_omni_sdk_api_dimension_di PARTITION (dt)
SELECT service_group,
    datasource,
    sdk_version,
    channel,
    country,
    os,
    os_version,
    vendor,
    device_model,
    url_path,
    host,
    dt
FROM dm_omni_sdk.dws_omni_sdk_api_di
WHERE dt = :dt
GROUP BY service_group,
    datasource,
    sdk_version,
    channel,
    country,
    os,
    os_version,
    vendor,
    device_model,
    url_path,
    host,
    dt

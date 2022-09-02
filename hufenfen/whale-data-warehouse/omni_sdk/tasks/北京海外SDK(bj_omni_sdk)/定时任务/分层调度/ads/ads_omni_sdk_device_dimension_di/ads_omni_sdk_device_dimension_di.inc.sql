-- 任务名: ads_omni_sdk_device_dimension_di
-- 作者: 翟旭亮
-- 功能: 聚合 dws_omni_sdk_uid_di 表将维度提取出来
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions.pernode = 400;
SET hive.exec.max.dynamic.partitions = 400;
INSERT OVERWRITE TABLE dm_omni_sdk.ads_omni_sdk_device_dimension_di PARTITION (dt)
SELECT data_source,
    app_id,
    msg_version,
    sdk_version,
    channel,
    country,
    app_name,
    project,
    company,
    online,
    host,
    os,
    os_version,
    device_brand,
    device_model,
    dt
FROM dm_omni_sdk.dws_omni_sdk_device_di
WHERE dt = :dt
GROUP BY data_source,
    app_id,
    msg_version,
    sdk_version,
    channel,
    country,
    app_name,
    project,
    company,
    online,
    host,
    os,
    os_version,
    device_brand,
    device_model,
    dt

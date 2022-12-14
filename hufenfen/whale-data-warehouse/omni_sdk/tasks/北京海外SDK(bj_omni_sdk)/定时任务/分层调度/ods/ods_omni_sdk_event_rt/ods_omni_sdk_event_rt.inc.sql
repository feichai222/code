-- Generated by HiveQL Generator, please don't modify.
-- https://git.shiyou.kingsoft.com/data/hiveql-generator
-- 从OmniSDK上报的原始数据 dw_omni_sdk.raw_omni_sdk_event 向 ODS 层表 dw_omni_sdk.ods_omni_sdk_event_rt 提取数据
-- 使用动态分区
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions.pernode = 400;
SET hive.exec.max.dynamic.partitions = 400;


INSERT OVERWRITE TABLE dw_omni_sdk.ods_omni_sdk_event_rt PARTITION (dt, event_name)
SELECT
    get_json_object(regexp_replace (raw_json, '#', '' ), '$.time_ms') AS time_ms, -- 解析JSON中的'time_ms'字段
    get_json_object(regexp_replace (raw_json, '#', '' ), '$.datasource') AS datasource, -- 解析JSON中的'datasource'字段
    get_json_object(regexp_replace (raw_json, '#', '' ), '$.account_id') AS account_id, -- 解析JSON中的'account_id'字段
    get_json_object(regexp_replace (get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '#', '' ), '$.ip') AS ip, -- 解析JSON中的'ip'字段
    get_json_object(regexp_replace (get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '#', '' ), '$.service_group') AS service_group, -- 解析JSON中的'service_group'字段
    get_json_object(regexp_replace (get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '#', '' ), '$.vendor') AS vendor, -- 解析JSON中的'vendor'字段
    get_json_object(regexp_replace (get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '#', '' ), '$.device_id') AS device_id, -- 解析JSON中的'device_id'字段
    get_json_object(regexp_replace (get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '#', '' ), '$.device_model') AS device_model, -- 解析JSON中的'time_ms'字段
    get_json_object(regexp_replace (get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '#', '' ), '$.os') AS os, -- 解析JSON中的'os'字段
    get_json_object(regexp_replace (get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '#', '' ), '$.os_version') AS os_version, -- 解析JSON中的'os_version'字段
    get_json_object(regexp_replace (get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '#', '' ), '$.sdk_version') AS sdk_version, -- 解析JSON中的'sdk_version'字段
    get_json_object(get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '$.game_id') AS game_id, -- 解析JSON中的'game_id'字段
    get_json_object(get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '$.another_device_id') AS another_device_id, -- 解析JSON中的'another_device_id'字段
    get_json_object(regexp_replace (get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties'), '#', '' ), '$.channel') AS channel, -- 解析JSON中的'channel'字段
    json2map(get_json_object(regexp_replace (raw_json, '#', '' ), '$.properties')) AS properties, -- 解析JSON中的'properties'字段
    dt,    get_json_object(regexp_replace (raw_json, '#', '' ), '$.event_name') AS event_name
FROM dw_omni_sdk.raw_omni_sdk_event
WHERE
    dt BETWEEN :dt AND date_add(:dt, 1)
    AND from_unixtime(CAST(get_json_object(regexp_replace (raw_json, '#', '' ), '$.time_ms')/1000 AS BIGINT), 'yyyy-MM-dd') = :dt
    AND get_json_object(regexp_replace (raw_json, '#', '' ), '$.event_name') IS NOT NULL;

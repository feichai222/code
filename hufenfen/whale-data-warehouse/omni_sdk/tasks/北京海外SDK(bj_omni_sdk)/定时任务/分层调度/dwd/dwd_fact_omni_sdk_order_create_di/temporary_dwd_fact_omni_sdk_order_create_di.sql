SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions.pernode = 400;
SET hive.exec.max.dynamic.partitions = 400;


INSERT OVERWRITE TABLE dw_omni_sdk.dwd_fact_omni_sdk_order_create_di PARTITION (dt)
SELECT
    time_ms, -- 上报的时间
    service_group, -- 数据源
    datasource, -- 请求来源
    game_id, -- 应用 ID
    null AS msg_version, -- 消息版本
    sdk_version, -- SDK 版本
    channel, -- 渠道名称
    device_id, -- 设备 ID
    account_id, -- SDK 用户唯一 ID
    properties['host'] AS host, -- 客户端请求 Host
    os, -- 操作系统类型
    os_version, -- 操作系统版本
    vendor, -- 手机品牌
    device_model, -- 手机型号
    properties['event_group'] AS event_group, -- 数据类型
    event_name, -- 事件类型
    another_device_id, -- 另一个设备 ID
    ip, -- 客户端IP
    ip_locate(ip) ['country'] AS country, -- IP解析之后的国家
    properties, -- 明细
    dt
FROM dw_omni_sdk.ods_new_omni_sdk_event_rt
WHERE
    dt = :dt
    
    AND event_name = 'create_order'
UNION
SELECT
    report_time, -- 上报的时间
    data_source, -- 数据源
    request_source, -- 请求来源
    app_id, -- 应用 ID
    msg_version, -- 消息版本
    sdk_version, -- SDK 版本
    channel, -- 渠道名称
    device_id, -- 设备 ID
    uid, -- SDK 用户唯一 ID
    host, -- 客户端请求 Host
    os, -- 操作系统类型
    os_version, -- 操作系统版本
    device_brand, -- 手机品牌
    device_model, -- 手机型号
    data_type, -- 数据类型
    event_type, -- 事件类型
    another_device_id, -- 另一个设备 ID
    client_ip, -- 客户端IP
    ip_locate(client_ip) ['country'] AS country, -- IP解析之后的国家
    event_detail, -- 明细
    dt
FROM dw_omni_sdk.ods_omni_sdk_event_rt
WHERE
    dt = :dt
    
    AND event_type = 'create_order';

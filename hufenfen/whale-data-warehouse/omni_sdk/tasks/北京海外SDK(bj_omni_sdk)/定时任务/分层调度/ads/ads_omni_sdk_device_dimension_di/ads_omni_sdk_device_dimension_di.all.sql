-- 使用动态分区
SET hive.exec.dynamic.partition.mode = nonstrict;
SET hive.exec.max.dynamic.partitions.pernode = 400;
SET hive.exec.max.dynamic.partitions = 400;


-- 变量
<#-- 定义日期格式和变量 -->
<#setting date_format="yyyy-MM-dd">
<#assign startDate = '2021-09-17'>
<#assign endDate = .now?date?iso_local>

<#-- 单次执行的天数, 最大 400 不能修改 -->
<#assign batchDays = 400>

<#-- 计算需要进行几次循环 -->
<#assign dayDiff = DateUtil.dayDiff(startDate?date, endDate?date)>
<#assign iterTimes = (dayDiff/batchDays)?int>
<#-- 如果向下取整之后变小了, 说明没有整除, 需要加一 -->
<#if iterTimes < dayDiff/batchDays>
<#assign iterTimes = iterTimes + 1>
</#if>

<#-- 开始循环 -->
<#list 1..iterTimes as index>
<#assign iterStartDate = DateUtil.addDays(startDate?string, (index - 1) * batchDays)>
<#assign iterEndDate = DateUtil.addDays(startDate?string, index * batchDays)>
<#-- 只要不是循环的最后一次, 都需要对结尾的日期减一 -->
<#if !index?is_last>
<#assign iterEndDate = DateUtil.addDays(startDate?string, index * batchDays - 1)>
</#if>
<#-- 循环内的结束日期不能超过循环外的结尾日期 -->
<#if iterEndDate?date gt endDate?date>
<#assign iterEndDate = endDate?date>
</#if>

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
WHERE dt BETWEEN '${iterStartDate}' AND '${iterEndDate}'
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
    dt;
</#list>

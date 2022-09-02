SELECT 
    SUM(CAST(units AS DECIMAL(10,2))) AS "下载数量",
    dt AS "日期"
    <#if (dimensions?? && dimensions?contains("game_name")) || game_name?? >
    ,game_name AS "游戏名称"
    </#if>
    <#if (dimensions?? && dimensions?contains("version")) || version?? >
    ,version AS "版本"
    </#if>
    <#if (dimensions?? && dimensions?contains("product_type")) || product_type?? >
    ,product_type AS "下载类型"
    </#if>
    <#if (dimensions?? && dimensions?contains("region")) || region?? >
    ,region AS "国家（地区）"
    </#if>
    FROM dm_omni_sdk.dws_app_store_sales_summary_daily_report_di
WHERE dt >= '${startDate}'
    AND dt <= '${endDate}'
    AND product_type_identifier in ('1','1-B','F1-B', '1F', '1T', '3', '3F', '7', '7F', '7T', 'F1', 'F7')
    <#if game_name?? >
    AND contains(split(:game_name,','),game_name)
    </#if>
    <#if version?? >
    AND contains(split(:version,','),version)
    </#if>
    <#if product_type?? >
    AND contains(split(:product_type,','),product_type)
    </#if>
    <#if region?? >
    AND contains(split(:region,','),region)
    </#if>
    GROUP BY
    dt
    <#if (dimensions?? && dimensions?contains("game_name")) || game_name?? >
    ,game_name
    </#if>
    <#if (dimensions?? && dimensions?contains("version")) || version?? >
    ,version
    </#if>
    <#if (dimensions?? && dimensions?contains("product_type")) || product_type?? >
    ,product_type
    </#if>
    <#if (dimensions?? && dimensions?contains("region")) || region?? >
    ,region
    </#if>
    ORDER BY
    dt,SUM(CAST(units AS DECIMAL(10,2))) DESC

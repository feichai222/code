SELECT SUM(CAST(units AS DECIMAL(10,2))) AS units
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
    FROM dm_omni_sdk.dws_app_store_sales_summary_daily_report_di
WHERE dt >= '${startDate}'
    AND dt <= '${endDate}'
    
        AND product_type_identifier in ('1','1-B','F1-B', '1F', '1T', '3', '3F', '7', '7F', '7T', 'F1', 'F7')<#if game_name?? >
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
    <#if dimensions?? || game_name??|| version??|| product_type??|| region??>
GROUP BY
</#if>
    <#assign started = false>
    <#if (dimensions?? && dimensions?contains("game_name")) || game_name?? >
    <#if started >,</#if>game_name
    <#assign started = true>
    </#if>
    <#if (dimensions?? && dimensions?contains("version")) || version?? >
    <#if started >,</#if>version
    <#assign started = true>
    </#if>
    <#if (dimensions?? && dimensions?contains("product_type")) || product_type?? >
    <#if started >,</#if>product_type
    <#assign started = true>
    </#if>
    <#if (dimensions?? && dimensions?contains("region")) || region?? >
    <#if started >,</#if>region
    <#assign started = true>
    </#if>
    ORDER BY units
    
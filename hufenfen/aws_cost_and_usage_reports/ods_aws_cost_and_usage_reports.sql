CREATE TABLE cost.ods_aws_cost_and_usage_reports (
    line_item String COMMENT ''
    ) 
ENGINE = S3(
    'https://shiyou-master-billings.s3.ap-southeast-1.amazonaws.com/aws-cur/shiyou-master-cur/*/*.csv.gz',
    'TabSeparated',
    'gzip'
) SETTINGS input_format_allow_errors_num = 1,
input_format_allow_errors_ratio = 1;

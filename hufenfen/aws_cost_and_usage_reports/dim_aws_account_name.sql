CREATE TABLE IF NOT EXISTS cost.dim_aws_account_name(
    account_id String COMMENT '账号 id',
    account_name String COMMENT '账号名称',
    account_function String COMMENT '账号功能'
)
ENGINE = S3('https://seayoo-analytics.s3.ap-southeast-1.amazonaws.com/analytics/jenkins/aws_cur/dim_aws_account_name.csv', 'CSV')
SETTINGS input_format_csv_skip_first_lines = 1;

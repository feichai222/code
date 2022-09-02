terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "shiyou-labs"
  region  = "us-east-1"
}

resource "aws_cur_report_definition" "example_cur_report_definition" {
  report_name                = "aws-cost-and-usage-reports"
  time_unit                  = "HOURLY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = "shiyou-labs-aws-cur"
  s3_region                  = "ap-east-1"
  report_versioning          = "OVERWRITE_REPORT"
}

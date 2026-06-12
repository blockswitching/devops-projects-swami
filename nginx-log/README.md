# nginx-log

This directory contains `nginx-log.sh`, a simple shell script for analyzing an NGINX access log.

## What it does

`nginx-log.sh` generates a summary report from an NGINX access log file, including:

- Top 5 IP addresses by request count
- Top 5 requested paths
- Top 5 HTTP status codes
- Top 5 user agents

## Usage

```bash
./nginx-log.sh /path/to/nginx-access.log
```

## Requirements

- `bash`
- `awk`
- `sort`
- `uniq`
- `head`

## Notes

The script expects a standard NGINX access log format. If the log file is missing or not provided, it exits with an error.

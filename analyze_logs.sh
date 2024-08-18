#!/bin/bash

cat <<EOL > access.log
192.168.1.1 - - [28/Jul/2024:12:34:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [28/Jul/2024:12:35:56 +0000] "POST /login HTTP/1.1" 200 567
192.168.1.3 - - [28/Jul/2024:12:36:56 +0000] "GET /home HTTP/1.1" 404 890
192.168.1.1 - - [28/Jul/2024:12:37:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.4 - - [28/Jul/2024:12:38:56 +0000] "GET /about HTTP/1.1" 200 432
192.168.1.2 - - [28/Jul/2024:12:39:56 +0000] "GET /index.html HTTP/1.1" 200 1234
EOL

total_requests=$(wc -l < access.log)
unique_ips=$(awk '{print $1}' access.log | sort | uniq | wc -l)
request_methods=$(awk -F'\" ' '{print $2}' access.log | awk '{print $1}' | sort | uniq -c | awk '{print $2 ": " $1}' | sort)
popular_url=$(awk -F'\" ' '{print $2}' access.log | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

report_file="report.txt"
{
    echo "Общее количество запросов: $total_requests"
    echo "Количество уникальных IP-адресов: $unique_ips"
    echo "Количество запросов по методам:"
    echo "$request_methods"
    echo "Самый популярный URL: $popular_url"
} > "$report_file"

chmod 644 "$report_file"

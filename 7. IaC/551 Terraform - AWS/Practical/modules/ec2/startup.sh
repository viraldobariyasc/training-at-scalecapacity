#!/bin/bash

apt-get update -y
apt-get install -y nginx mysql-client

systemctl start nginx
systemctl enable nginx

# Raw endpoint from Terraform
RAW_RDS_ENDPOINT="${rds_endpoint}"

# Extract host (remove :3306 if present)
RDS_HOST=$(echo $RAW_RDS_ENDPOINT | cut -d':' -f1)
RDS_PORT=3306

DB_USER="root"
DB_PASS="root1234"

# Debug logs
echo "Raw endpoint: $RAW_RDS_ENDPOINT" > /tmp/debug.log
echo "Parsed host: $RDS_HOST" >> /tmp/debug.log
echo "Port: $RDS_PORT" >> /tmp/debug.log

# Test connectivity (TCP check)
nc -zv $RDS_HOST $RDS_PORT > /tmp/network_check.txt 2>&1

# MySQL connection test
mysql -h $RDS_HOST -P $RDS_PORT -u $DB_USER -p$DB_PASS -e "SHOW DATABASES;" > /tmp/db_result.txt 2>&1

if [ $? -eq 0 ]; then
  STATUS="✅ Connected to RDS successfully"
else
  STATUS="❌ Failed to connect to RDS"
fi

# Create HTML page
cat <<HTML > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>RDS Connection Status</title>
<style>
body { font-family: Arial; text-align: center; margin-top: 50px; }
h1 { color: green; }
pre { text-align: left; width: 60%; margin: auto; background: #f4f4f4; padding: 20px; }
</style>
</head>
<body>
<h1>$STATUS</h1>

<h2>Network Check</h2>
<pre>
$(cat /tmp/network_check.txt)
</pre>

<h2>Database Output</h2>
<pre>
$(cat /tmp/db_result.txt)
</pre>

<h2>Debug Info</h2>
<pre>
$(cat /tmp/debug.log)
</pre>

</body>
</html>
HTML

systemctl restart nginx
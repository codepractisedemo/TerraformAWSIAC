#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y nginx
systemctl enable nginx
cat >/usr/share/nginx/html/index.html <<HTML
<!DOCTYPE html>
<html>
  <head>
    <title>Terraform EC2 in eu-central-1</title>
  </head>
  <body>
    <h1>EC2 deployed successfully with Terraform + GitHub Actions</h1>
    <p>Region: eu-central-1</p>
  </body>
</html>
HTML
systemctl start nginx

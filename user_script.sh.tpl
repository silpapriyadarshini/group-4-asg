#!/bin/bash

sudo yum update
sudo service apache2 start
sudo systemctl enable apache2.service
sudo systemctl start apache2

# Web Page
cat <<EOF > /var/www/html/index.html
<html>
<title> ${version} </title>
<body style="background-color:${color};">
<h1> This is the ${version} !! </h1>
</body>
</html>
EOF
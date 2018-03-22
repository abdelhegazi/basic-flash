#!/bin/sh
yum -y update
yum -y install epel-release
echo "Hello, Utas" > index.html
yum -y install python-pip python-dev curl git net-tools ns
pip install Flask
pip install --upgrade pip
git clone https://github.com/abdelhegazi/basic-flask-python.git /app/
/usr/bin/python /app/app/app.py &

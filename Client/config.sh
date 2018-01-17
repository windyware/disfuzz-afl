#!/bin/bash

# install the requirements 
 
echo '[+] install epel-release ...'
yum install epel-release

echo '[+] install python-pip ...'
yum install python-pip
pip install --upgrade pip 

echo '[+] install python-devel ...'
yum install python-devel 

echo '[+] install gcc ...'
yum install gcc 

echo '[+] install psutil ...'
pip install psutil 

echo '[+] install requests ...'
pip install requests 

echo '[+] install tmuxp ...'
pip install tmuxp

# set afl core dump
echo '[+] set /proc/sys/kernel/core_pattern' 
echo >/proc/sys/kernel/core_pattern 

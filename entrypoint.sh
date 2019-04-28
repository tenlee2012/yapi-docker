#!/bin/bash

# yapi初始化后会有一个init.lock文件
lockPath="/yapi/log/init.lock"

logPath="/yapi/log/server.log"
# 进入yapi项目
cd /yapi/vendors

# 如果初始化文件文件存在,则直接运行,否则初始化
if [ ! -f "$lockPath" ]
then
  # 启动Yapi初始化
  node server/install.js
  touch $lockPath
  # 若是初始化成功的情况下直接运行yapi
  nohup node server/app.js > $logPath 2>&1 &
  tail -f $logPath
else
  # 运行yapi管理系统
  nohup node server/app.js > $logPath 2>&1 &
  tail -f $logPath
fi
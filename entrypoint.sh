#!/bin/sh

if [ -n "$CRON_EXPR" ]; then
  # 写入定时任务
  echo "$CRON_EXPR /app/cfst $ARGS" > /var/spool/cron/crontabs/root
  echo "Cron job scheduled: $CRON_EXPR"
  
  # 容器启动时先立刻执行一次测速
  /app/cfst $ARGS
  
  # 启动 crond 守护进程保持容器前台运行
  exec crond -f -l 2
else
  # 如果没有设置定时任务，则直接运行一次后退出
  exec /app/cfst $ARGS
fi

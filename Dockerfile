FROM alpine:latest

# 安装证书、时区和 cron 守护进程
RUN apk --no-cache add ca-certificates tzdata crond

WORKDIR /app

# 1. 复制 Go 编译出来的核心程序
COPY cfst ./

# 2. 复制原本仓库里的 IP 库
COPY ip.txt ipv6.txt ./

# 3. 复制我们刚刚创建的启动脚本，并赋予执行权限
COPY entrypoint.sh ./
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

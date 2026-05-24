FROM alpine:latest
RUN apk --no-cache add ca-certificates tzdata crond
WORKDIR /app
COPY cfst ./
COPY ip.txt ipv6.txt ./

# 创建启动脚本
RUN printf '#!/bin/sh\nif [ -n "$CRON_EXPR" ]; then\n  echo "$CRON_EXPR /app/cfst $ARGS" > /var/spool/cron/crontabs/root\n  echo "Cron job scheduled: $CRON_EXPR"\n  /app/cfst $ARGS\n  exec crond -f -l 2\nelse\n  exec /app/cfst $ARGS\nfi\n' > /app/entrypoint.sh && chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

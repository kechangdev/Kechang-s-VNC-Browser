FROM alpine:latest AS builder

RUN apk add --no-cache \
    wget \
    curl \
    unzip

RUN mkdir -p /opt/noVNC/utils/websockify \
    && wget -qO- https://github.com/novnc/noVNC/archive/v1.3.0.tar.gz | tar xz --strip 1 -C /opt/noVNC \
    && wget -qO- https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar xz --strip 1 -C /opt/noVNC/utils/websockify

FROM alpine:latest

COPY --from=builder /opt/noVNC /opt/noVNC

RUN apk add --no-cache \
    chromium \
    xvfb \
    x11vnc \
    fluxbox \
    ttf-freefont \
    supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 5900 6080

CMD ["/start.sh"]

# 
# Usage: 
# 
# 1. With default setting in foreground.
# 
#    docker run ssserver
#
# 2. With default setting in background
# 
#    docker run -d ssserver
#
# 3. Change password and running port
# 
#    docker run -d -e port=<port> password=<password> ssserver
# 

FROM alpine:3.5

ENV port 443
ENV password 123456
ENV method aes-256-cfb

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    && pip install shadowsocks
    
ENTRYPOINT ssserver -p ${port} -k ${password} -m ${method}

##
## knxmonitor
##

## Use latest Alpine based images as starting point
FROM python:2.7-alpine

# Select branch
ARG BRANCH=master

COPY entrypoint.sh /

RUN apk add --no-cache git  \
    && git clone https://github.com/TrondKjeldas/knxmonitor.git --single-branch --branch $BRANCH \
    && cd knxmonitor \
    && python setup.py build \
    && python setup.py install \
    && addgroup -S knxmon \
    && adduser -D -S -s /sbin/nologin -G knxmon knxmon \
    && chmod a+x /entrypoint.sh \
    && apk del --no-cache git

#COPY knxd.ini /root
#COPY knxd.ini /etc/knxd

#EXPOSE 3672 6720
VOLUME /knxlogs

ENTRYPOINT ["/entrypoint.sh"]
CMD ["ip:knxd"]

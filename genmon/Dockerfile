FROM python

RUN apt update -y
RUN apt upgrade -y

#The timezone specified here just bypasses some required configuration, it does not appear to be configuring a persistent setting.
RUN DEBIAN_FRONTEND="noninteractive" TZ="America/New_York" apt install -y sudo cron net-tools nano

EXPOSE 22
EXPOSE 443
EXPOSE 8000

RUN git clone http://github.com/jgyates/genmon.git /opt/genmon
RUN chmod 775 startgenmon.sh
RUN chmod 775 genmonmaint.sh
RUN /bin/bash /git/genmon/genmonmaint.sh -i -n
RUN /git/genmon/startgenmon.sh start

RUN sed -i 's/use_serial_tcp = False/use_serial_tcp = True/g' /etc/genmon/genmon.conf

CMD /git/genmon/startgenmon.sh start && tail -F /var/log/genmon.log

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Randy Brown <slamdf150xc@gmail.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Randy Brown <slamdf150xc@gmail.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

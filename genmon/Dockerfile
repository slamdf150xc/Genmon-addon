ARG BUILD_FROM
FROM $BUILD_FROM

EXPOSE 8000

VOLUME /addons

RUN apk update
RUN apk add --no-cache git net-tools sudo gcc cmake make libffi-dev cargo libmodbus-dev

RUN pip3 install --upgrade pip

RUN git clone https://github.com/jgyates/genmon.git /opt/genmon

WORKDIR /opt/genmon

RUN pip install -r requirements.txt

RUN chmod +x /opt/genmon/genmonmaint.sh
RUN /bin/bash /opt/genmon/genmonmaint.sh -i -n

RUN chmod +x /opt/genmon/startgenmon.sh
RUN /opt/genmon/startgenmon.sh start

COPY run.sh /
RUN chmod +x /run.sh
CMD [ "/run.sh" ]

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

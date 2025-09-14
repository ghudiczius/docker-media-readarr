FROM mcr.microsoft.com/dotnet/runtime:10.0-alpine3.22

ARG SOURCE_CHANNEL
ARG VERSION

# renovate: datasource=repology depName=alpine_3_22/curl versioning=loose
ENV CURL_VERSION=8.14.1-r1
# renovate: datasource=repology depName=alpine_3_22/sqlite-libs versioning=loose
ENV SQLITE_LIBS_VERSION=3.49.2-r1

RUN apk add --no-cache --update \
        curl="${CURL_VERSION}" \
        sqlite-libs="${SQLITE_LIBS_VERSION}" && \
    addgroup -g 1000 readarr && \
    adduser -D -G readarr -h /opt/readarr -H -s /bin/sh -u 1000 readarr && \
    mkdir /config /downloads /books /opt/readarr && \
    curl --location --output /tmp/readarr.tar.gz "https://github.com/Readarr/Readarr/releases/download/v${VERSION}/Readarr.${SOURCE_CHANNEL}.${VERSION}.linux-core-x64.tar.gz" && \
    tar xzf /tmp/readarr.tar.gz --directory=/opt/readarr --strip-components=1 && \
    chown --recursive 1000:1000 /config /downloads /books /opt/readarr && \
    rm /tmp/readarr.tar.gz

USER 1000
VOLUME /config /downloads /books
WORKDIR /opt/readarr

EXPOSE 7878
ENTRYPOINT ["/opt/readarr/Readarr"]
CMD ["-data=/config", "-nobrowser"]

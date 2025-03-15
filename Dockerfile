FROM mcr.microsoft.com/dotnet/runtime:9.0

ARG SOURCE_CHANNEL
ARG VERSION

# renovate: release=bookworm depName=curl
ENV CURL_VERSION=7.88.1-10+deb12u12
# renovate: release=bookworm depName=libsqlite3-0
ENV LIBSQLITE_VERSION=3.40.1-2+deb12u1

RUN apt-get update && \
    apt-get --assume-yes --quiet install \
        curl="${CURL_VERSION}" \
        libsqlite3-0="${LIBSQLITE_VERSION}" && \
    groupadd --gid=1000 readarr && \
    useradd --gid=1000 --home-dir=/opt/readarr --no-create-home --shell /bin/bash --uid 1000 readarr && \
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

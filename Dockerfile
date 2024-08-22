FROM mcr.microsoft.com/dotnet/runtime:5.0

ARG VERSION

RUN apt-get update && \
    apt-get --assume-yes install curl libsqlite3-0 && \
    groupadd --gid=1000 readarr && \
    useradd --gid=1000 --home-dir=/opt/readarr --no-create-home --shell /bin/bash --uid 1000 readarr && \
    mkdir /config /downloads /books /opt/readarr && \
    curl --location --output /tmp/readarr.tar.gz "https://github.com/Readarr/Readarr/releases/download/v${VERSION}/Readarr.develop.${VERSION}.linux-core-x64.tar.gz" && \
    tar xzf /tmp/readarr.tar.gz --directory=/opt/readarr --strip-components=1 && \
    chown --recursive 1000:1000 /config /downloads /books /opt/readarr && \
    rm /tmp/readarr.tar.gz

USER 1000
VOLUME /config /downloads /books
WORKDIR /opt/readarr

EXPOSE 7878
CMD ["/opt/readarr/Readarr", "-data=/config", "-nobrowser"]

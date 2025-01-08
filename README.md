# Readarr

Simple docker image for Readarr without any bloat, built on the official dotnet runtime image. Readarr runs as user `readarr` with `uid` and `gid` `1000` and listens on port `8787`.

## Usage

```sh
docker run --rm ghudiczius/readarr:<VERSION> \
  -p 8787:8787 \
  -v path/to/config:/config \
  -v path/to/downloads:/downloads \
  -v path/to/books:/books
```

or

```sh
docker run --rm registry.gitlab.jmk.hu/media/readarr:<VERSION> \
  -p 8787:8787 \
  -v path/to/config:/config \
  -v path/to/downloads:/downloads \
  -v path/to/books:/books
```

A Dockerfile and environment file suitable for running the SNAP LPS demo
notebook. The image bundles the packages included in CDSE's Sentinel Hub
environment, Jupyter Lab, SNAP 12, and esa-snappy, and starts a Jupyter
server by default when run.

To build (with `docker` as CWD):

```bash
docker build --tag snapdemo:1 .
```

To run:

```bash
docker run --rm -p 8888:8888 snapdemo:1
```

A Jupyter Lab environment is served at the URL printed to the terminal.

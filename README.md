# snap-docker

![](https://github.com/snap-contrib/docker-snap/workflows/Docker/badge.svg)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

This is a project for the creation of Docker images containing the latest published SNAP version (currently SNAP 12).

The project is based on an earlier setup for SNAP 8, 
see https://github.com/snap-contrib/docker-snap. 

The main goals are to run Docker containers with SNAP
from cloud environments and to access the corresponding <i>esa_snappy</i> from Jupyter notebooks.

## Accessing and using the docker images

A docker image containing an Ubuntu environment, a Python environment (Python version 3.10), and a SNAP 12 installation with
<i>esa_snappy</i> configured and ready to use can be pulled from

```console
docker pull quay.io/bcdev/snap12_python
```

A docker image with reduced size containing an Ubuntu environment and a SNAP 12 installation (but no Python environment) can be pulled from

```console
docker pull quay.io/bcdev/snap12
```

This image can be used for running the SNAP Desktop GUI inside a Docker container.

## Further information

A more detailed guide on how to use these Docker images in a properly prepared environment is given at

[Install and run SNAP from Docker images](https://senbox.atlassian.net/wiki/spaces/SNAP/pages/3296755713/Install+and+run+SNAP+from+Docker+images)

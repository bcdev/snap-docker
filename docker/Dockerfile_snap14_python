# ########################################################################################

# Dockerfile to build an image with Ububntu + SNAP + Python installation + Snappy configured

# Build the image with:
#   > docker build -f ./Dockerfile_snap14_python --no-cache --tag snap14_python:1 .

# Run the image with:
#   > docker run --rm -p 8888:8888 snap14_python:1

# Deploy the container (quay.io login with bcdev-2 credentials):
#   > docker ps
#   > docker login
#   > docker commit <CONTAINER ID> quay.io/bcdev/snap14_python
#   > docker push quay.io/bcdev/snap14_python

# Executed on BC wvcci_vm (Ubuntu 22.04, Docker v24.0.2)

# TODO: pass SNAP version (here 14) as parameter; test migration to CIQA

# ########################################################################################


# install Ubuntu...
FROM mambaorg/micromamba:ubuntu24.04

WORKDIR /home/mambauser

# install some extensions, set user to root for next steps...
USER root
RUN apt-get -qq update && apt-get -qq install -y curl xauth x11-apps libxtst6 libxxf86vm1

# download and install SNAP...
RUN curl -O \
    https://download.esa.int/step/snap/14.0/installers/esa-snap_all_linux-14.0.0.sh && \
    sh esa-snap_all_linux-14.0.0.sh -q && \
    rm esa-snap_all_linux-14.0.0.sh

# check for SNAP module updates...
RUN /opt/esa-snap/bin/snap --nosplash --nogui --modules --list --refresh
RUN /opt/esa-snap/bin/snap --nosplash --nogui --modules --update-all

# install Python (micromamba)...
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# configure esa-snappy...
RUN /opt/esa-snap/bin/snappy-conf /opt/conda/bin/python

# set user back to mambauser...
USER $MAMBA_USER

# start Jupyter server at container startup...
CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser"]

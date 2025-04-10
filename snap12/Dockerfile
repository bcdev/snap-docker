FROM ubuntu:20.04

MAINTAINER Brockmann Consult GmbH
USER root

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    SHELL=/bin/bash \
    PATH=/srv/conda/bin:$PATH \
    DEBIAN_FRONTEND=noninteractive \
    NB_USER=jovyan \
    NB_UID=1002 \
    NB_GID=1002 \
    APP_BASE=/srv
    
ENV USER=${NB_USER} \ 
    HOME=/home/${NB_USER} \
    CONDA_DIR=${APP_BASE}/conda

    
RUN groupadd --gid ${NB_GID} ${NB_USER}                                                                                             && \
    useradd --comment "Default user" --create-home --gid ${NB_GID} --no-log-init --shell /bin/bash --uid ${NB_UID} ${NB_USER}       && \
    apt-get -qq update                                                                                                              && \
    apt-get -qq install --yes apt-utils                                                                                             && \
    apt-get -qq install --yes --no-install-recommends ttf-dejavu \
            wget make g++ sudo vim less unzip tree file libgfortran5 locales > /dev/null                                            && \
    apt-get -qq purge                                                                                                               && \
    apt-get -qq clean                                                                                                               && \
    rm -rf /var/lib/apt/lists/*                                                                                                     && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment                                                                                   && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen                                                                                     && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf                                                                                      && \
    locale-gen en_US.UTF-8

# conda installation via miniforge
ADD ./install-miniforge.bash /tmp/install-miniforge.bash

RUN chmod 755 /tmp/install-miniforge.bash                                                                                           && \
    /tmp/install-miniforge.bash                                                                                                     && \
    rm -f /tmp/install-*.bash                                                                                                       && \
    chown -R $NB_USER:$NB_GID ${HOME}

USER ${NB_USER}

ENV PATH=${CONDA_DIR}/envs/env_snap/snap/bin:${CONDA_DIR}/envs/env_snap/bin:${CONDA_DIR}/bin:$PATH \
    KERNEL_PYTHON_PREFIX=${CONDA_DIR}/envs/env_snap  \
    PREFIX=${CONDA_DIR}/envs/env_snap

ADD ./environment.yml /tmp/environment.yml

RUN mamba env create -f /tmp/environment.yml                                                                 && \
    mamba clean --all -f -y

WORKDIR ${HOME}

# copy Jupyter notebooks
#
RUN mkdir -p ${CONDA_DIR}/envs/env_snap/notebooks
COPY ./notebooks/*.ipynb ${CONDA_DIR}/envs/env_snap/notebooks

# SNAP installation dir (final location tbd)
# e.g. /data/software/snap12_rc/esa-snap
# --> docker build --build-arg SNAP_INSTALL_DIR=/data/software/snap12_rc/esa-snap ...
#ARG SNAP_INSTALL_DIR

# copy required files from SNAP installation dir to Docker image (${CONDA_DIR}/envs/env_snap):

ENV SNAP_DEST=${CONDA_DIR}/envs/env_snap/esa-snap

RUN mkdir -p ${SNAP_DEST}/etc \
    ${SNAP_DEST}/jre \
    ${SNAP_DEST}/platform \
    ${SNAP_DEST}/rstb \
    ${SNAP_DEST}/snap \
    ${SNAP_DEST}/microwavetbx \
    ${SNAP_DEST}/opttbx/ \
    ${HOME}\.snap\snap-python

ADD ./bla.txt ${SNAP_DEST}/bla.txt
#COPY ./LICENSE.txt ${SNAP_DEST}/LICENSE.txt

#COPY ${SNAP_INSTALL_DIR}/THIRDPARTY_LICENSES.txt ${SNAP_DEST}/THIRDPARTY_LICENSES.TXT
#COPY ${SNAP_INSTALL_DIR}/VERSION.txt ${SNAP_DEST}/VERSION.TXT
#COPY ${SNAP_INSTALL_DIR}/etc/ ${SNAP_DEST}/etc/
#COPY ${SNAP_INSTALL_DIR}/jre/ ${SNAP_DEST}/jre/
#COPY ${SNAP_INSTALL_DIR}/platform/ ${SNAP_DEST}/platform/
#COPY ${SNAP_INSTALL_DIR}/rstb/ ${SNAP_DEST}/rstb/
#COPY ${SNAP_INSTALL_DIR}/snap/ ${SNAP_DEST}/snap/
#COPY ${SNAP_INSTALL_DIR}/microwavetbx/ ${DEST}/microwavetbx/
#COPY ${SNAP_INSTALL_DIR}/opttbx/ ${DEST}/opttbx/

# Python installation dir
# e.g. /data/software/miniconda3_py310
# --> docker build --build-arg SNAP_INSTALL_DIR=/data/software/snap12_rc/esa-snap PYTHON_INSTALL_DIR=/data/software/miniconda3_py310...
# ARG PYTHON_INSTALL_DIR

# pip install esa-snappy...
#RUN ${CONDA_DIR}/envs/env_snap/bin/python -m pip install esa-snappy

# run snappy-conf on host...
#RUN ${SNAP_INSTALL_DIR}/bin/snappy-conf ${CONDA_DIR}/envs/env_snap/bin/python
# copy required files from Python installation dir to Docker image...

WORKDIR ${HOME}

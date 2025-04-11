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
    SNAP_DIR=${APP_BASE}/esa-snap

    
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

ENV PATH=${SNAP_DIR}/snap/bin:${CONDA_DIR}/bin:$PATH \
    KERNEL_PYTHON_PREFIX=${CONDA_DIR}  \
    PREFIX=${CONDA_DIR}

ADD ./environment.yml /tmp/environment.yml

WORKDIR ${HOME}

# copy Jupyter notebooks
#
RUN mkdir -p ${CONDA_DIR}/notebooks
COPY ./notebooks/*.ipynb ${CONDA_DIR}/notebooks

# copy required files from SNAP installation dir to Docker image (${CONDA_DIR}/envs/env_snap):

RUN mkdir -p ${SNAP_DIR}

RUN mkdir -p ${SNAP_DIR}/etc \
    ${SNAP_DIR}/bin \
    ${SNAP_DIR}/jre \
    ${SNAP_DIR}/platform \
    ${SNAP_DIR}/rstb \
    ${SNAP_DIR}/snap \
    ${SNAP_DIR}/microwavetbx \
    ${SNAP_DIR}/opttbx/ \

COPY ./esa-snap/VERSION.txt ${SNAP_DIR}/VERSION.TXT
COPY ./esa-snap/etc/ ${SNAP_DIR}/etc/
COPY ./esa-snap/bin/ ${SNAP_DIR}/bin/
COPY ./esa-snap/jre/ ${SNAP_DIR}/jre/
COPY ./esa-snap/platform/ ${SNAP_DIR}/platform/
COPY ./esa-snap/rstb/ ${SNAP_DIR}/rstb/
COPY ./esa-snap/snap/ ${SNAP_DIR}/snap/
COPY ./esa-snap/microwavetbx/ ${SNAP_DIR}/microwavetbx/
COPY ./esa-snap/opttbx/ ${SNAP_DIR}/opttbx/

# pip install esa-snappy...
RUN ${CONDA_DIR}/bin/python -m pip install esa-snappy

# pip install jupyter...
RUN ${CONDA_DIR}/bin/python -m pip install jupyter

# run snappy-conf on host...
RUN mkdir -p ${HOME}/.snap/snap-python
RUN ${SNAP_DIR}/bin/snappy-conf ${CONDA_DIR}/envs/env_snap/bin/python

WORKDIR ${HOME}

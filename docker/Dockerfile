FROM mambaorg/micromamba:ubuntu24.04

COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1

WORKDIR /home/mambauser

RUN curl -O \
    https://download.esa.int/step/snap/12.0/installers/esa-snap_all_linux-12.0.0.sh && \
    sh esa-snap_all_linux-12.0.0.sh -q && \
    rm esa-snap_all_linux-12.0.0.sh

#RUN ./esa-snap/bin/snappy-conf /opt/conda/bin/python

#CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser"]

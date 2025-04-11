#!/bin/bash
# This downloads and installs a pinned version of miniconda
set -ex

cd $(dirname $0)
#MAMBAFORGE_VERSION=4.9.2-3
# Python 3.12, Oct 2024:
MAMBAFORGE_VERSION=24.9.0-0
#URL="https://github.com/conda-forge/miniforge/releases/download/${MAMBAFORGE_VERSION}/Mambaforge-${MAMBAFORGE_VERSION}-Linux-x86_64.sh"
URL="https://github.com/conda-forge/miniforge/releases/download/${MAMBAFORGE_VERSION}/Miniforge3-${MAMBAFORGE_VERSION}-Linux-x86_64.sh"
INSTALLER_PATH=/tmp/miniforge-installer.sh

# make sure we don't do anything funky with user's $HOME
# since this is run as root
unset HOME

wget --quiet --no-check-certificate $URL -O ${INSTALLER_PATH}
chmod +x ${INSTALLER_PATH}

bash ${INSTALLER_PATH} -b -p ${CONDA_DIR}
export PATH="${CONDA_DIR}/bin:$PATH"

# Preserve behavior of miniconda - packages come from conda-forge + defaults
conda config --system --append channels conda-forge
conda config --system --append channels defaults
conda config --system --append channels r

# Do not attempt to auto update conda or dependencies
conda config --system --set auto_update_conda false
conda config --system --set show_channel_urls true

# bug in conda 4.3.>15 prevents --set update_dependencies
echo 'update_dependencies: false' >> ${CONDA_DIR}/.condarc

# avoid future changes to default channel_priority behavior
conda config --system --set channel_priority "flexible"

# Clean things out!
mamba clean --all -f -y

# Remove the big installer so we don't increase docker image size too much
rm ${INSTALLER_PATH}

# Remove the pip cache created as part of installing miniforge
rm -rf /root/.cache

chown -R $NB_USER:$NB_GID ${CONDA_DIR}

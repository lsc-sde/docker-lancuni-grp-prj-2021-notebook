# Custom data science notebook for LANDER
ARG OWNER=vvcb
ARG BASE_CONTAINER=jupyter/tensorflow-notebook
FROM $BASE_CONTAINER

LABEL maintainer="vvcb"

COPY jupyter_notebook_config.json /etc/jupyter/jupyter_notebook_config.json
COPY requirements.txt requirements.txt

RUN mamba install -c conda-forge \
    --yes --file requirements.txt \
    && mamba clean --all -f -y \
    && rm requirements.txt \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}" 

USER root
RUN apt update \
    && apt install --yes graphviz

USER ${NB_USER}
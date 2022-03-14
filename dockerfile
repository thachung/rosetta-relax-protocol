#syntax=docker/dockerfile:1
FROM ubuntu AS base
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="Asia/Hong Kong"
#apt-get
#mpich libmpich-dev \
SHELL ["/bin/bash", "-c"]
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends apt-utils bc && \
    apt-get install -y --no-install-recommends tzdata && \
    apt-get install -y --no-install-recommends \
    gcc gfortran g++ \
    libopenmpi-dev openmpi-bin openmpi-common libomp-dev \
    zlib1g-dev python openssh-server ca-certificates && \
    apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM base AS builder
COPY rosetta*.tgz /home/rosetta.tgz
WORKDIR /home
ENV OMPI_ALLOW_RUN_AS_ROOT=1 OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1
RUN tar xfz rosetta.tgz
WORKDIR /home/rosetta_src_2021.16.61629_bundle/main/source
RUN ./scons.py -j $(nproc) mode=release bin/relax.cxx11threadmpiserialization.linuxgccrelease extras=mpi,cxx11thread,serialization

FROM base as main_mpi_relax
ENV OMPI_ALLOW_RUN_AS_ROOT=1 OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1
COPY --from=builder /home/rosetta_src_2021.16.61629_bundle/main/source/build/ /home/rosetta_src_2021.16.61629_bundle/main/source/build/
COPY --from=builder /home/rosetta_src_2021.16.61629_bundle/main/database/ /home/rosetta_src_2021.16.61629_bundle/main/database/
WORKDIR /home/runtime
COPY relaxscript.sh relaxscript.sh
CMD bash
#ENTRYPOINT mpiexec --use-hwthread-cpus /home/rosetta_src_2021.16.61629_bundle/main/source/build/src/release/linux/5.10/64/x86/gcc/9/cxx11thread-mpi-serialization/relax.cxx11threadmpiserialization.linuxgccrelease

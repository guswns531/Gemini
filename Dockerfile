# call from repo root

#FROM nvidia/cuda:10.0-devel AS build
# FROM nvidia/cuda:11.2.2-devel AS build
FROM nvidia/cuda:11.4.0-devel-ubuntu18.04 AS build


WORKDIR /tmp/build

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

RUN apt update && \
    apt install -y git python3 && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Seoul apt-get install -y libglib2.0 libzmq3-dev 

COPY . Gemini

RUN cd Gemini && \
    make -C src

FROM python:3.8.1-buster

RUN pip3 install inotify

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Seoul apt-get install -y libglib2.0 libzmq3-dev 

ENV NVIDIA_VISIBLE_DEVICES      all
ENV NVIDIA_DRIVER_CAPABILITIES  utility

COPY ./gemini-lib/libdl.so.2          /lib
COPY ./gemini-lib/libnvidia-ml.so.1   /lib
COPY ./gemini-lib/libnorm.so.1   /lib
COPY ./gemini-lib/libpgm-5.2.so.0   /lib
COPY ./gemini-lib/libsodium.so.23   /lib
COPY ./gemini-lib/libzmq.so.5   /lib
COPY --from=build /tmp/build/Gemini/bin/gem-schd /gem-schd

# CMD ["/launcher-multigpus.sh", "/kubeshare/scheduler/config", "/kubeshare/scheduler/podmanagerport"]
CMD ["./gem-schd", "-p", "/kubeshare/scheduler/ipc", "-f", "/sys/kernel/gpu/gemini/resource_conf", "-w", "10.0"]

# docker build -t guswns531/kubeshare-gemini-scheduler:v2.9 ./
# docker push guswns531/kubeshare-gemini-scheduler:v2.9
# 

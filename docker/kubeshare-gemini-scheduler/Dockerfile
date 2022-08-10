# call from repo root

#FROM nvidia/cuda:10.0-devel AS build
FROM nvidia/cuda:11.2.2-devel AS build

WORKDIR /tmp/build

COPY . kubeshare

# RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/3bf863cc.pub

RUN rm /etc/apt/sources.list.d/cuda* &&\ 
    apt-get update &&\ 
    apt-key del 7fa2af80 &&\ 
    sed -i '/developer\.download\.nvidia\.com\/compute\/cuda\/repos/d' /etc/apt/sources.list &&\ 
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub

RUN apt update && \
    apt install -y git python3 && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Seoul apt-get install -y libglib2.0 libzmq3-dev  &&\
    git clone https://github.com/guswns531/Gemini.git && cd Gemini && \
    make -C src

# CMD ["python3", "/tmp/build/Gemini/tools/launch-command.py", "--hook", "/kubeshare/library/libgemhook.so.1", "--name", "node4", "'/tmp/build/Gemini/bin/gem-schd -f /kubeshare/scheduler/resource.conf'"]


FROM python:3.8.1-buster

RUN pip3 install inotify

RUN rm /etc/apt/sources.list.d/cuda* &&\ 
    apt-get update &&\ 
    apt-key del 7fa2af80 &&\ 
    sed -i '/developer\.download\.nvidia\.com\/compute\/cuda\/repos/d' /etc/apt/sources.list &&\ 
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb &&\ 
    dpkg -i cuda-keyring_1.0-1_all.deb

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Seoul apt-get install -y libglib2.0 libzmq3-dev 

ENV NVIDIA_VISIBLE_DEVICES      all
ENV NVIDIA_DRIVER_CAPABILITIES  utility

COPY docker/lib/libdl.so.2          /lib
COPY docker/lib/libnvidia-ml.so.1   /lib
COPY docker/lib/libnorm.so.1   /lib
COPY docker/lib/libpgm-5.2.so.0   /lib
COPY docker/lib/libsodium.so.23   /lib
COPY docker/lib/libzmq.so.5   /lib

COPY --from=build /tmp/build/kubeshare/docker/kubeshare-gemini-scheduler/launcher-multigpus.sh /launcher-multigpus.sh
# COPY --from=build /tmp/build/kubeshare/docker/kubeshare-gemini-scheduler/launcher.py /launcher.py
COPY --from=build /tmp/build/Gemini/bin/gem-schd /gem-schd
# COPY --from=build /tmp/build/Gemini/bin/gem-pmgr /gem-pmgr

CMD ["/launcher-multigpus.sh", "/kubeshare/scheduler/config", "/kubeshare/scheduler/podmanagerport"]


# docker build -t guswns531/kubeshare-gemini-scheduler:v2.5 docker/kubeshare-gemini-scheduler
# docker push guswns531/kubeshare-gemini-scheduler:v2.5
# 

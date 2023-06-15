# call from repo root

# FROM nvidia/cuda:10.0-devel AS build
# FROM nvidia/cuda:11.2.2-devel AS build
FROM nvidia/cuda:11.4.0-devel-ubuntu18.04 AS build

WORKDIR /tmp/build


COPY . Gemini

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

RUN apt update && \
    apt install -y git python3 && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Seoul apt-get install -y libglib2.0 libzmq3-dev  &&\
    cd Gemini && \
    make -C src #DEBUG=1

# FROM busybox:1.31.1-glibc
FROM alpine:3.9

COPY --from=build /tmp/build/Gemini/lib/libgemhook.so.1 /libgemhook.so.1
COPY --from=build /usr/lib/x86_64-linux-gnu/libnorm.so.1  /libnorm.so.1
COPY --from=build /usr/lib/x86_64-linux-gnu/libpgm-5.2.so.0 /libpgm-5.2.so.0
COPY --from=build /usr/lib/x86_64-linux-gnu/libsodium.so.23  /libsodium.so.23
COPY --from=build /usr/lib/x86_64-linux-gnu/libzmq.so.5  /libzmq.so.5
COPY docker/lib/copylib.sh /copylib.sh

RUN chmod 777 /copylib.sh

CMD ["/copylib.sh"]

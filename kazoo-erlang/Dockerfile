FROM kazoo/base-os

ARG REPO=https://github.com/2600hz/kazoo.git
ARG COMMIT=HEAD

USER root

COPY build/setup-os.sh build/setup-os.sh
RUN build/setup-os.sh

USER user

COPY etc/version version
COPY build/setup-erlang.sh build/setup-erlang.sh
RUN build/setup-erlang.sh

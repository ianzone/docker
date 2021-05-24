FROM kazoo/erlang:21.3

# override on run with --env option
ENV NETWORK=kazoo
ENV NODE_NAME=kazoo
ENV KAZOO_APPS=sysconf,blackhole,callflow,cdr,conference,crossbar,fax,hangups,media_mgr,milliwatt,omnipresence,pivot,registrar,reorder,stepswitch,teletype,trunkstore,webhooks,ecallmgr
ENV COUCHDB=couchdb.$NETWORK
ENV RABBITMQ=rabbitmq.$NETWORK
ENV VERSION 21.3

# override on build with --build-arg option
ARG REPO=https://github.com/2600hz/kazoo.git
ARG SKIP_BUILD
ARG BRANCH
ARG UID
ARG GID

RUN git clone $REPO kazoo
COPY etc/commit /home/user/commit

COPY build/setup.sh build/setup.sh
RUN build/setup.sh

COPY etc/config.ini config.ini

ENV PATH $PATH:/home/user/bin
COPY build/sup bin/sup 

COPY build/cmd.sh ./cmd.sh

COPY build/setup_uid.sh build/setup_uid.sh
USER root
RUN build/setup_uid.sh
USER user

COPY etc/sys.config sys.config
COPY build/build.sh build/build.sh
RUN build/build.sh

#RUN find kazoo -name "*.erl" -delete \
 #  && rm -rf kazoo/.git
 #  && rm -r /tmp/sup.erl

RUN git clone --depth 1 --no-single-branch https://github.com/2600hz/kazoo-sounds \
   && mv kazoo-sounds/kazoo-core/en/us /home/user/us \
   && rm -rf kazoo-sounds

ENV HOME /home/user
ENV KAZOO_NODE $NODE_NAME@kazoo.kazoo
ENV RELX_REPLACE_OS_VARS true
ENV KZname "-name $KAZOO_NODE"
ENV KAZOO_APPS sysconf,blackhole,callflow,cdr,conference,crossbar,fax,hangups,media_mgr,milliwatt,omnipresence,pivot,registrar,reorder,stepswitch,teletype,trunkstore,webhooks,ecallmgr
ENV PATH $PATH:/home/user/kazoo/_rel/kazoo/bin/
ENV KAZOO_CONFIG /home/user/config.ini
# RUN sed -i "s|couchdb.kazoo|$COUCHDB|" /home/user/config.ini
# RUN sed -i "s|rabbitmq.kazoo|$RABBITMQ|" /home/user/config.ini

USER root
RUN echo change_me > .erlang.cookie
RUN sed -i "s|_rel|/home/user/kazoo/_rel|" /home/user/bin/sup
USER user

COPY build/run.sh run.sh
ENTRYPOINT ./run.sh

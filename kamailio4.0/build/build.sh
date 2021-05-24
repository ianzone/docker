#!/bin/sh -e
cd libevbuffsock
make
make install

cd ../libnsq
make
make install

cd ../
cp libnsq/utlist.h /usr/local/include/

cd ./kamailio

INCLUDE_MODULES="acc \
auth \
auth_openbts \
avp \
avpops \
cfg_rpc \
cfgutils \
corex \
ctl \
debugger \
dispatcher \
htable \
ipops \
jsonrpcs \
kazoo \
kex \
maxfwd \
mqueue \
nathelper \
outbound \
path \
permissions \
pike \
presence \
presence_dialoginfo \
presence_mwi \
presence_xml \
pua \
pua_bla \
pua_mi \
pua_reginfo \
pua_usrloc \
pua_xmpp \
pv \
registrar \
rr \
rtimer \
sanity \
sdpops \
siputils \
sl \
sqlops \
statistics \
stun \
tcpops \
textops \
textopsx \
timer \
tls \
tm \
tmx \
tsilo \
uac \
uac_redirect \
usrloc \
uuid \
websocket \
xhttp \
xlog \
alias_db \
async \
auth_db \
auth_diameter \
auth_openbts \
auth_xkeys \
benchmark \
blst \
call_control \
cfg_db \
cfgt \
counters \
db_cluster \
db_flatstore \
db2_ops \
dialog \
diversion \
dmq \
dmq_usrloc \
domain \
domainpolicy \
drouting \
enum \
exec \
group \
imc \
log_custom \
malloc_test \
mangler \
matrix \
mediaproxy \
mohqueue \
msilo \
msrp \
mtree \
nat_traversal \
nosip \
p_usrloc \
pdb \
pdt \
pipelimit \
prefix_route \
print \
print_lib \
pua_mi \
qos \
ratelimit \
rtjson \
rtpengine \
rtpproxy \
sca \
seas \
sipcapture \
sipt \
siptrace \
sms \
smsops \
speeddial \
ss7ops \
sst \
statsc \
statsd \
tmrec \
topoh \
topos \
uid_auth_db \
uid_avp_db \
uid_domain \
uid_gflags \
uid_uri_db \
uri_db \
userblacklist \
xhttp_rpc \
xprint"

EXCLUDE_MODULES=""

make FLAVOUR=kamailio cfg \
    prefix=/usr/local/lib64/kamailio \
    skip_modules="${EXCLUDE_MODULES}" \
    include_modules="${INCLUDE_MODULES}" \
    SCTP=0 \
    STUN=1 \
    TLS_HOOKS=1

# make group_include="standard standard-dep stable experimental" all
make
make install

#!/bin/bash

echo "start etcd"
nohup etcd >/tmp/etcd.log 2>&1 &

sleep 1

echo "copy the plugins/*"
cp -r /agw/apisix/plugins/* /usr/local/apisix/apisix/plugins/

echo "copy the t/*"
cp -r /agw/apisix/t/* /usr/local/apisix/t/

echo "run test"

export PATH=/usr/local/openresty/nginx/sbin:$PATH

# why: ci/centos7-ci.sh run_case
export OPENRESTY_PREFIX="/usr/local/openresty-debug"
export APISIX_MAIN="https://raw.githubusercontent.com/apache/incubator-apisix/master/rockspec/apisix-master-0.rockspec"
export PATH=$OPENRESTY_PREFIX/nginx/sbin:$OPENRESTY_PREFIX/luajit/bin:$OPENRESTY_PREFIX/bin:$PATH

FLUSH_ETCD=1 prove --timer -Itest-nginx/lib -I./  t/*.t


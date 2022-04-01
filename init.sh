#!/bin/bash

function golang () {
    # 设置代理
    go env -w GO111MODULE=on
    go env -w GOPROXY=https://goproxy.cn,direct

    # 安装 protobuf
    # apt-get update
    # apt-get install -y gogoprotobuf
}

hello () {
    echo "hello world"
}

$@

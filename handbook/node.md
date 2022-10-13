## Node 学习手册

### 常见问题

#### 错误码: ERR_OSSL_EVP_UNSUPPORTED

出现这个错误是因为 node.js V17及以后版本中最近发布的OpenSSL3.0,

而OpenSSL3.0对允许算法和密钥大小增加了严格的限制，可能会对生态系统造成一些影响.

在node.js V17以前一些可以正常运行的的应用程序,但是在 V17 及以后版本可能会抛出以下异常:

```sh
{
  ...
  opensslErrorStack: [ 'error:03000086:digital envelope routines::initialization error' ],
  library: 'digital envelope routines',
  reason: 'unsupported',
  code: 'ERR_OSSL_EVP_UNSUPPORTED'
}

# solustion
export NODE_OPTIONS=--openssl-legacy-provider
```

#### GRPC 安装

需要安装两个包 npm 或 yarn 皆可

- [ts-protoc-gen](npmjs.com/package/ts-protoc-gen)
- [grpc-tools](npmjs.com/package/grpc-tools)

```sh
# xuyao 
yarn add ts-protoc-gen # protoc-gen-ts
yarn add grpc-tools  # grpc_tools_node_protoc_plugin

# 生成命令 demo
protoc --plugin=protoc-gen-ts=/usr/local/bin/protoc-gen-ts \
  --plugin=protoc-gen-grpc=./node_modules/.bin/grpc_tools_node_protoc_plugin \
  --js_out=import_style=commonjs,binary:./src/models/grpc \
  --ts_out=service=grpc-node,mode=grpc-js:./src/models/grpc \
  --grpc_out=grpc_js:./src/models/grpc \
  *.proto

## gen files
# proto/
# |-- *.ts
# |-- *_grpc_pb.js
# `-- *.js

```

问题 
protoc-gen-js: program not found or is not executable

[StackOverflow](https://stackoverflow.com/questions/72572040/protoc-gen-js-program-not-found-or-is-not-executable)
```
brew install protobuf@3
brew link --overwrite protobuf@3
```

#### Build 常见问题

- 编译报错

``` sh
HookWebpackError: The service is no longer running

# 问题原因 esbuild目录下服务未运行，运行根目录install
# 解决方式: 

node node_modules/esbuild-loader/node_modules/esbuild/install.js
```

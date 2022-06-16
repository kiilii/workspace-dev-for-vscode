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
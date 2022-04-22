# nginx 编译

依赖 make automake pcre openssl(libssh-dev)



``` sh
./configure --help  # 查看配置

./configure  --prefix=/usr/local/nginx  \
--sbin-path=/usr/local/nginx/sbin/nginx \
--conf-path=/usr/local/nginx/conf/nginx.conf \
--error-log-path=/var/log/nginx/error.log  \
--http-log-path=/var/log/nginx/access.log  \
--pid-path=/var/run/nginx/nginx.pid \
--lock-path=/var/lock/nginx.lock  \
--user=nginx --group=nginx \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--http-client-body-temp-path=/var/tmp/nginx/client/ \
--http-proxy-temp-path=/var/tmp/nginx/proxy/ \
--http-fastcgi-temp-path=/var/tmp/nginx/fcgi/ \
--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
--http-scgi-temp-path=/var/tmp/nginx/scgi --with-pcre
```

## 使用

``` sh
nginx -s reload
nginx -s restart
nginx -s stop

# 配置文件语法测试
nginx -t ./test.conf
```
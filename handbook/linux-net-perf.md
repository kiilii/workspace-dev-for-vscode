## linux 网络性能调优

### 命令

检查当前 linux 服务器多有连接情况
``` sh
netstat -an | awk '/^tcp/ {++y[$NF]} END {for(w in y) print w, y[w]}'

LISTEN 8
ESTABLISHED 2400
FIN_WAIT1 2
TIME_WAIT 6000
```

### 参数调优

1. net.ipv4.tcp_syncookies = 1 表示开启 syn cookies 。当出现 syn 等待队列溢出时，启用 cookies 来处理，可防范少量 syn 攻击，默认为 0 ，表示关闭； 
2. net.ipv4.tcp_tw_reuse = 1 表示开启重用。允许将 time-wait sockets 重新用于新的 tcp 连接，默认为 0 ，表示关闭；
3. net.ipv4.tcp_tw_recycle = 1 表示开启 tcp 连接中 time-wait sockets 的快速回收，默认为 0 ，表示关闭。
4. net.ipv4.tcp_fin_timeout 修改系靳默认的 timeout 时间
5. net.ipv4.tcp_keepalive_time = 1200 #表示当keepalive起用的时候，TCP发送keepalive消息的频度。缺省是2小时，改为20分钟。
6. net.ipv4.ip_local_port_range = 1024 65000 #表示用于向外连接的端口范围。缺省情况下很小：32768到61000，改为1024到65000。
7. net.ipv4.tcp_max_syn_backlog = 8192 #表示SYN队列的长度，默认为1024，加大队列长度为8192，可以容纳更多等待连接的网络连接数。
8. net.ipv4.tcp_max_tw_buckets = 5000 #表示系统同时保持TIME_WAIT套接字的最大数量，如果超过这个数字，TIME_WAIT套接字将立刻被清除并打印警告信息。


* tcp_tw_recycle 副作用是会拒绝所有比这个客户端时间戳更靠前的网络包。如果时间非同步，则很可能出现服务器拒绝数据包的情况， 一般推荐不使用
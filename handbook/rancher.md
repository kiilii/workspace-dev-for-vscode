## 问题


- rancher server 部署
``` shell
docker run --name=rancher --restart=always --privileged=true -p 9090:9090 rancher/server:least
```

- rancher agent 部署

注意要点
1. 单机部署时，添加主机 IP 不要填 localhost(127.0.0.1), 尽量使用局域网 IP 或公网 IP
2. 如果 agent 内部报错: DNS Checking loopback IP address 127.0.0.0/8, localhost or ::1 configured as the DNS server on the host file /etc/resolv.conf, can’t accept it, 参考 [rancher doc](https://rancher.com/docs/rancher/v1.6/en/faqs/agents/) 和 [docker doc](https://docs.docker.com/engine/install/linux-postinstall/) 解决
 
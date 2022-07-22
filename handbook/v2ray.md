## 不可说


#### 服务端

``` sh
bash <(curl -s -L https://git.io/v2ray-setup.sh)

bash <(curl -s -L https://git.io/v2rayinstall.sh)

# 根据提示安装

# output:
---------- V2Ray 配置信息 -------------

 地址 (Address) = 207.148.27.37

 端口 (Port) = 8080

 用户ID (User ID / UUID) = 20be1f8e-2169-4aa1-843e-5ead4250a9f7

 额外ID (Alter Id) = 0

 传输协议 (Network) = kcp

 伪装类型 (header type) = dtls

---------- END -------------

V2Ray 客户端使用教程: https://git.io/v2ray-client

提示: 输入 v2ray url 可生成 vmess URL 链接 / 输入 v2ray qr 可生成二维码链接

---------- V2Ray vmess URL / V2RayNG v0.4.1+ / V2RayN v2.1+ / 仅适合部分客户端 -------------

vmess://ewoidiI6I*****g==*
```


### clash 使用

[配置文档详解](https://github.com/Dreamacro/clash/wiki/configuration)


- proxies： 配置代理
    - DIRECT
    - REJECT 拒绝

- proxy-groups: 代理组, 由多个代理即模式组成
    - url-test: 通过对 URL 的速度进行基准测试来选择将使用哪个代理。
    - fallback: 按顺序选择可用策略。 通过访问 URL 来测试可用性，就像自动 url-test 组一样。
    - load-balance：同一个eTLD+1的请求会被拨到同一个proxy。
    - select: 用于选择代理或代理组，您可以使用 RESTful API 切换代理建议在 GUI 中使用

- rules: 规则适配 (匹配模式,匹配字符,目标代理或代理组)
    - DOMAIN-SUFFIX: 域名后缀匹配模式
    - PROCESS-NAME: applications 适配
    - RULE-SET: 规则集匹配 [说明文档](https://github.com/Loyalsoldier/clash-rules)

下列配置示例可适配 vmess，需配置 proxies

``` yaml
#---------------------------------------------------#
## 配置文件需要放置在 $HOME/.config/clash/*.yaml

## 这份文件是clashX的基础配置文件，请尽量新建配置文件进行修改。
## ！！！只有这份文件的端口设置会随ClashX启动生效

## 如果您不知道如何操作，请参阅 官方Github文档 https://github.com/Dreamacro/clash/blob/dev/README.md
#---------------------------------------------------#

# (HTTP and SOCKS5 in one port)
mixed-port: 7890
# RESTful API for clash
external-controller: 127.0.0.1:9090
allow-lan: false
mode: rule
log-level: warning

# 透明代理开启DNS
dns:
  enable: true
  ipv6: false
  listen: 0.0.0.0:1053
  enhanced-mode: redir-host # redir-host or fake-ip
  # fake-ip-range: 198.18.0.1/16 # Fake IP addresses pool CIDR
  use-hosts: true # lookup hosts and return IP record
  nameserver:
    - 119.29.29.29 # DNSpod DNS 17ms
    - 223.5.5.5 # 阿里 19ms
  # 提供 fallback 时，如果GEOIP非 CN 中国时使用 fallback 解析
  fallback:
    - tls://8.8.8.8:853 # Google DNS over TLS
    - tls://8.8.4.4:853 # cloudflare DNS over TLS
    - https://1.1.1.1/dns-query # cloudflare DNS over HTTPS
    - https://dns.google/dns-query # Google DNS over HTTPS
  # 强制DNS解析使用`fallback`配置
  fallback-filter:
    # true: CN使用nameserver解析，非CN使用fallback
    geoip: true
    # geoip设置为false时有效： 不匹配`ipcidr`地址时会使用`nameserver`结果，匹配`ipcidr`地址时使用`fallback`结果。
    ipcidr:
      - 240.0.0.0/4
tun:
  enable: true
  stack: system
  dns-hijack:
    - 114.114.114.114
  macOS-auto-route: true
  macOS-auto-detect-interface: false

proxies:
  # vmess
  # cipher support auto/aes-128-gcm/chacha20-poly1305/none
  - name: "xxx-代理"
    type: vmess
    server: server.com
    port: 443
    uuid: uuid
    alterId: 0
    cipher: auto
    tls: true
    network: ws
    ws-path: /
  # - name: "xxx-代理2"
  #   type: vmess
  #   server: server
  #   port: 443
  #   uuid: uuid
  #   alterId: 0
  #   cipher: auto
  #   tls: true
  #   network: ws
  #   ws-path: /
proxy-groups:
  - name: PROXY
    type: url-test
    proxies:
      - "xxx-代理"
    url: http://www.gstatic.com/generate_204
    interval: 300
  - name: cn1
    type: select
    interface-name: en1
    routing-mark: 6667
    proxies:
      - DIRECT 
  - name: PROXY2
    type: select
    proxies:
      - "xxx-代理"

rule-providers:
  reject:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/reject.txt
    path: ./ruleset/reject.yaml
    interval: 86400
  icloud:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/icloud.txt
    path: ./ruleset/icloud.yaml
    interval: 86400
  apple:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/apple.txt
    path: ./ruleset/apple.yaml
    interval: 86400
  google:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/google.txt
    path: ./ruleset/google.yaml
    interval: 86400
  proxy:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/proxy.txt
    path: ./ruleset/proxy.yaml
    interval: 86400
  direct:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/direct.txt
    path: ./ruleset/direct.yaml
    interval: 86400
  private:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/private.txt
    path: ./ruleset/private.yaml
    interval: 86400
  gfw:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/gfw.txt
    path: ./ruleset/gfw.yaml
    interval: 86400
  greatfire:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/greatfire.txt
    path: ./ruleset/greatfire.yaml
    interval: 86400
  tld-not-cn:
    type: http
    behavior: domain
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/tld-not-cn.txt
    path: ./ruleset/tld-not-cn.yaml
    interval: 86400
  telegramcidr:
    type: http
    behavior: ipcidr
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/telegramcidr.txt
    path: ./ruleset/telegramcidr.yaml
    interval: 86400
  cncidr:
    type: http
    behavior: ipcidr
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/cncidr.txt
    path: ./ruleset/cncidr.yaml
    interval: 86400
  lancidr:
    type: http
    behavior: ipcidr
    url: https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/lancidr.txt
    path: ./ruleset/lancidr.yaml
    interval: 86400
  
rules:
  - DOMAIN-SUFFIX,docker.com,DIRECT
  - DOMAIN-SUFFIX,netsarang.com,PROXY
  - DOMAIN-SUFFIX,create.io,PROXY
  - DOMAIN-SUFFIX,neotech.top,PROXY
  - DOMAIN-SUFFIX,optimizely.com,PROXY
  - DOMAIN-SUFFIX,mouseflow.com,PROXY
  - DOMAIN-SUFFIX,cloudfront.net,PROXY
  - DOMAIN-SUFFIX,gorm.io,PROXY
  - DOMAIN-SUFFIX,docker.com,PROXY
  - DOMAIN-SUFFIX,baidu.com,DIRECT
  - DOMAIN-SUFFIX,f2pool.com,DIRECT
  - DOMAIN-SUFFIX,supportxmr.com,DIRECT
  - PROCESS-NAME,v2ray,DIRECT
  - PROCESS-NAME,xray,DIRECT
  - PROCESS-NAME,naive,DIRECT
  - PROCESS-NAME,trojan,DIRECT
  - PROCESS-NAME,trojan-go,DIRECT
  - PROCESS-NAME,ss-local,DIRECT
  - PROCESS-NAME,privoxy,DIRECT
  - PROCESS-NAME,leaf,DIRECT
  - PROCESS-NAME,v2ray.exe,DIRECT
  - PROCESS-NAME,xray.exe,DIRECT
  - PROCESS-NAME,naive.exe,DIRECT
  - PROCESS-NAME,trojan.exe,DIRECT
  - PROCESS-NAME,trojan-go.exe,DIRECT
  - PROCESS-NAME,ss-local.exe,DIRECT
  - PROCESS-NAME,privoxy.exe,DIRECT
  - PROCESS-NAME,leaf.exe,DIRECT
  - PROCESS-NAME,Surge,DIRECT
  - PROCESS-NAME,Surge 2,DIRECT
  - PROCESS-NAME,Surge 3,DIRECT
  - PROCESS-NAME,Surge 4,DIRECT
  - PROCESS-NAME,Surge%202,DIRECT
  - PROCESS-NAME,Surge%203,DIRECT
  - PROCESS-NAME,Surge%204,DIRECT
  - PROCESS-NAME,Thunder,DIRECT
  - PROCESS-NAME,DownloadService,DIRECT
  - PROCESS-NAME,qBittorrent,DIRECT
  - PROCESS-NAME,Transmission,DIRECT
  - PROCESS-NAME,fdm,DIRECT
  - PROCESS-NAME,aria2c,DIRECT
  - PROCESS-NAME,Folx,DIRECT
  - PROCESS-NAME,NetTransport,DIRECT
  - PROCESS-NAME,uTorrent,DIRECT
  - PROCESS-NAME,WebTorrent,DIRECT
  - PROCESS-NAME,aria2c.exe,DIRECT
  - PROCESS-NAME,BitComet.exe,DIRECT
  - PROCESS-NAME,fdm.exe,DIRECT
  - PROCESS-NAME,NetTransport.exe,DIRECT
  - PROCESS-NAME,qbittorrent.exe,DIRECT
  - PROCESS-NAME,Thunder.exe,DIRECT
  - PROCESS-NAME,ThunderVIP.exe,DIRECT
  - PROCESS-NAME,transmission-daemon.exe,DIRECT
  - PROCESS-NAME,transmission-qt.exe,DIRECT
  - PROCESS-NAME,uTorrent.exe,DIRECT
  - PROCESS-NAME,WebTorrent.exe,DIRECT
  - DOMAIN,clash.razord.top,DIRECT
  - DOMAIN,yacd.haishan.me,DIRECT
  - RULE-SET,private,DIRECT
  - RULE-SET,reject,REJECT
  - RULE-SET,icloud,DIRECT
  - RULE-SET,apple,DIRECT
  - RULE-SET,google,DIRECT
  - RULE-SET,proxy,PROXY
  - RULE-SET,direct,DIRECT
  - RULE-SET,lancidr,DIRECT
  - RULE-SET,cncidr,DIRECT
  - RULE-SET,telegramcidr,PROXY
  - GEOIP,,DIRECT
  - GEOIP,CN,DIRECT
  - MATCH,PROXY
```
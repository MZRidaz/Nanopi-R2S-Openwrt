# OpenWrt / ImmortalWrt LuCI 插件清单（按功能分类）

> 本文档由你提供的《插件翻译表.xlsx》（ImmortalWrt 官方 LuCI 插件库对照表）自动整理生成。
> 说明：此清单以 **luci-app-*** 为主；是否存在对应的 **luci-i18n-*-zh-cn** 语言包取决于上游 feed。

## 目录
- [系统管理与维护](#系统管理与维护)
- [界面与主题](#界面与主题)
- [网络与路由（防火墙/QoS/负载/拨号/组播）](#网络与路由防火墙qos负载拨号组播)
- [DNS/域名/广告过滤/加密解析](#dns域名广告过滤加密解析)
- [代理/隐私/加速（HTTP/SOCKS/透明代理）](#代理隐私加速httpsocks透明代理)
- [VPN/组网/隧道/内网穿透](#vpn组网隧道内网穿透)
- [无线/热点/Mesh/漫游](#无线热点mesh漫游)
- [存储/共享/文件服务（含云盘/同步）](#存储共享文件服务含云盘同步)
- [下载/媒体/娱乐](#下载媒体娱乐)
- [监控/统计/通知](#监控统计通知)
- [安全与防护](#安全与防护)
- [容器与虚拟化](#容器与虚拟化)
- [硬件/外设/物联网](#硬件外设物联网)
- [校园网/认证/运营商相关](#校园网认证运营商相关)

## 系统管理与维护

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-acl` | ACL管理 | Luci中设置不同的用户角色,每个角色拥有不同的权限。 |
| `luci-app-acme` | ACME证书工具 | 自动申请和更新Let's Encrypt SSL证书。 |
| `luci-app-advanced-reboot` | 高级重启 | 支持安全模式、强制重启等选项。 |
| `luci-app-attendedsysupgrade` | 系统自动升级 | 检测并安装OpenWrt固件更新。 |
| `luci-app-autoreboot` | 定时重启 | 设置计划任务定时重启路由器。 |
| `luci-app-commands` | 自定义命令 | 在Web界面直接执行Shell命令。 |
| `luci-app-cpufreq` | CPU频率调节 | 动态调整CPU频率以节能或提频。 |
| `luci-app-cpulimit` | CPU占用限制 | 限制特定进程的CPU使用率。 |
| `luci-app-csshnpd` | CSSH节点管理 | 集群SSH管理工具（具体功能需查证）。 |
| `luci-app-example` | 示例插件 | OpenWrt开发模板（无实际功能）。 |
| `luci-app-irqbalance` | IRQ中断平衡 | 优化CPU中断分配以提升性能。 |
| `luci-app-openwisp` | OpenWISP管理 | 集中管理多个OpenWrt设备（企业级）。 |
| `luci-app-package-manager` | 软件包管理 | 图形化安装/卸载OpenWrt插件。 |
| `luci-app-ramfree` | 内存清理工具 | 手动释放系统内存。 |
| `luci-app-rustdesk-server` | RustDesk服务器 | 自建RustDesk远程桌面服务器。 |
| `luci-app-timewol` | 定时网络唤醒 | 按计划唤醒局域网设备（WOL）。 |
| `luci-app-ttyd` | TTYD网页终端 | 通过浏览器访问路由器的命令行界面。 |
| `luci-app-uhttpd` | uHTTPd Web服务器 | OpenWrt默认的轻量级Web服务器。 |
| `luci-app-vlmcsd` | KMS激活服务器 | 搭建Windows/Office KMS激活服务器。 |
| `luci-app-wol` | 网络唤醒工具 | 通过局域网唤醒设备（WOL）。 |
| `luci-app-xinetd` | Xinetd服务管理 | 管理超级守护进程（如TFTP服务）。 |

## 界面与主题

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-argon-config` | Argon主题配置 | 管理OpenWrt的Argon主题界面。 |

## 网络与路由（防火墙/QoS/负载/拨号/组播）

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-appfilter` | 应用流量过滤 | 按应用类型（游戏/视频）限制带宽。 |
| `luci-app-eqos` | 平等QoS管理 | 按IP/端口分配带宽优先级。 |
| `luci-app-firewall` | 防火墙管理 | 配置IPv4/IPv6防火墙规则。 |
| `luci-app-keepalived` | Keepalived高可用 | 实现网络服务高可用（VRRP协议）。 |
| `luci-app-lldpd` | LLDP邻居发现 | 检测网络中的相邻设备（类似CDP）。 |
| `luci-app-mwan3` | 多WAN负载均衡 | 多宽带接入的流量分配和故障转移。 |
| `luci-app-natmap` | NAT端口映射 | 动态NAT端口转发管理。 |
| `luci-app-nft-qos` | NFTables QoS | 基于nftables的流量控制。 |
| `luci-app-omcproxy` | OMC代理 | 组播代理服务（用于IPTV等）。 |
| `luci-app-pbr` | 策略路由 | 基于策略的流量路由（如国内外分流）。 |
| `luci-app-pppoe-relay` | PPPoE中继 | 转发PPPoE协议（用于多级路由）。 |
| `luci-app-pppoe-server` | PPPoE服务端 | 搭建PPPoE服务器（如ISP认证）。 |
| `luci-app-qos` | QoS流量控制 | 传统基于IP的带宽限制（旧版）。 |
| `luci-app-rp-pppoe-server` | RP-PPPoE服务端 | 另一种PPPoE服务器实现。 |
| `luci-app-sqm` | SQM QoS | 智能队列管理（优化网络延迟）。 |
| `luci-app-syncdial` | 多拨助手 | 单线多拨（宽带叠加）。 |
| `luci-app-udpxy` | UDPxy组播转发 | 将IPTV组播流转为HTTP单播流。 |
| `luci-app-upnp` | UPnP端口映射 | 自动为游戏/P2P应用配置端口转发。 |

## DNS/域名/广告过滤/加密解析

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-adblock` | 广告屏蔽 | 通过DNS拦截广告域名。 |
| `luci-app-adblock-fast` | 广告屏蔽（快速版） | 高性能DNS广告过滤，减少延迟。 |
| `luci-app-antiblock` | 反网络封锁 | 绕过地域限制（如DNS解锁）。 |
| `luci-app-cloudflared` | Cloudflare隧道 | 通过Cloudflare建立安全远程访问。 |
| `luci-app-ddns` | 动态DNS服务 | 集成花生壳、DynDNS等DDNS服务商。 |
| `luci-app-ddns-go` | DDNS-Go动态域名 | 轻量级动态域名解析（支持多平台）。 |
| `luci-app-https-dns-proxy` | HTTPS DNS代理 | 加密DNS查询（如Cloudflare DNS-over-HTTPS）。 |
| `luci-app-nextdns` | NextDNS配置 | 集成NextDNS加密DNS服务。 |
| `luci-app-smartdns` | SmartDNS域名解析 | 智能DNS分流（国内外域名优化解析）。 |
| `luci-app-unbound` | Unbound DNS解析 | 递归DNS服务器（替代Dnsmasq）。 |

## 代理/隐私/加速（HTTP/SOCKS/透明代理）

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-dae` | DAE代理工具 | 高性能透明代理（类似Clash）。 |
| `luci-app-daed` | DAED代理工具 | DAE的衍生版本（功能优化）。 |
| `luci-app-gost` | GOST代理工具 | 多协议代理（支持SOCKS5/HTTP等）。 |
| `luci-app-homeproxy` | imm官方代理工具 | 简化代理服务器配置（如科学上网）。 |
| `luci-app-microsocks` | MicroSocks代理 | 轻量级SOCKS5代理服务器。 |
| `luci-app-openclash` | OpenClash代理 | 集成Clash内核的代理工具（科学上网）。 |
| `luci-app-passwall` | PassWall代理 | 多协议代理工具（支持SS/V2Ray/Trojan）。 |
| `luci-app-privoxy` | Privoxy代理过滤 | 隐私增强的Web代理（广告过滤/防追踪）。 |
| `luci-app-squid` | Squid代理缓存 | HTTP代理服务器（支持缓存加速）。 |
| `luci-app-tinyproxy` | TinyProxy轻量代理 | 小型HTTP代理服务器。 |
| `luci-app-tor` | Tor匿名网络 | 配置Tor匿名代理服务。 |
| `luci-app-v2raya` | V2RayA代理管理 | 图形化配置V2Ray代理。 |

## VPN/组网/隧道/内网穿透

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-eoip` | EOIP隧道工具 | 基于以太网的IP隧道（类似VPN）。 |
| `luci-app-frpc` | Frp内网穿透客户端 | 通过Frp实现内网服务外网访问。 |
| `luci-app-frps` | Frp内网穿透服务端 | 搭建Frp服务器端。 |
| `luci-app-ipsec-vpnd` | IPSec VPN服务端 | 搭建IPSec VPN服务器。 |
| `luci-app-libreswan` | Libreswan VPN | 基于IPSec的VPN解决方案。 |
| `luci-app-n2n` | N2N VPN工具 | 点对点VPN组网工具。 |
| `luci-app-ngrokc` | Ngrok内网穿透 | 通过Ngrok实现内网穿透。 |
| `luci-app-nps` | NPS内网穿透 | 轻量级内网穿透工具。 |
| `luci-app-ocserv` | OpenConnect VPN | 搭建Cisco兼容的VPN服务器。 |
| `luci-app-openvpn` | OpenVPN客户端 | 配置OpenVPN客户端连接。 |
| `luci-app-openvpn-server` | OpenVPN服务端 | 搭建OpenVPN服务器。 |
| `luci-app-pagekitec` | PageKite内网穿透 | 通过PageKite实现内网服务外网访问。 |
| `luci-app-softether` | SoftEther VPN | 多功能VPN服务器（支持L2TP/IPSec/OpenVPN）。 |
| `luci-app-softethervpn` | SoftEther VPN管理 | SoftEther的增强管理界面。 |
| `luci-app-sshtunnel` | SSH隧道工具 | 通过SSH创建加密隧道。 |
| `luci-app-strongswan-swanctl` | StrongSwan VPN | 基于swanctl配置的IPSec VPN工具。 |
| `luci-app-xfrpc` | XFRP内网穿透 | 基于Frp的轻量级内网穿透工具。 |
| `luci-app-zerotier` | ZeroTier组网工具 | 创建虚拟局域网（SD-WAN）。 |
| `Tailscale` | Tailscale组网工具 | 与zerotier一样异地组网工具 |

## 无线/热点/Mesh/漫游

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-babeld` | Babel路由协议 | 支持多跳无线Mesh网络。 |
| `luci-app-bmx7` | BMX7路由协议 | 无线Mesh网络协议支持。 |
| `luci-app-cd8021x` | 802.1X企业认证 | 支持企业级网络认证（如EAP）。 |
| `luci-app-coovachilli` | CoovaChilli热点认证 | 用于公共WiFi热点认证（如酒店）。 |
| `luci-app-dawn` | 分布式无线管理 | 优化多AP间的无缝漫游（支持802.11k/v/r）。 |
| `luci-app-dcwapd` | DCWAPD服务 | 分布式无线控制协议支持（具体功能需查证）。 |
| `luci-app-olsr` | OLSR路由协议 | 优化链路状态路由（Mesh网络协议）。 |
| `luci-app-olsr-services` | OLSR服务发现 | OLSR Mesh网络的服务公告功能。 |
| `luci-app-olsr-viz` | OLSR拓扑可视化 | 图形化显示OLSR Mesh网络拓扑。 |
| `luci-app-splash` | 热点认证页面 | 公共WiFi的认证跳转页面（如酒店）。 |
| `luci-app-travelmate` | 旅行WiFi助手 | 自动切换可用的无线热点（如出差使用）。 |
| `luci-app-usteer` | 无线负载均衡 | 优化多AP间的客户端分配（类似802.11k/v）。 |
| `luci-app-wifischedule` | WiFi定时开关 | 按计划启用/禁用无线网络。 |

## 存储/共享/文件服务（含云盘/同步）

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-cifs-mount` | CIFS共享挂载 | 挂载Windows/Samba网络共享文件夹。 |
| `luci-app-diskman` | 磁盘管理工具 | 管理硬盘分区、RAID和挂载点。 |
| `luci-app-dufs` | Dufs文件服务器 | 简易HTTP文件共享服务。 |
| `luci-app-filebrowser` | 文件浏览器 | 旧版文件管理工具。 |
| `luci-app-filebrowser-go` | 文件浏览器（Go版） | 轻量级Web文件管理器。 |
| `luci-app-filemanager` | 文件管理器 | 支持文件上传、下载、编辑的Web工具。 |
| `luci-app-hd-idle` | 硬盘休眠工具 | 设置硬盘自动休眠以节能。 |
| `luci-app-ksmbd` | KSMBD共享服务 | 高性能SMB/CIFS文件共享（Linux内核级）。 |
| `luci-app-nfs` | NFS共享服务 | 网络文件系统（NFS）共享管理。 |
| `luci-app-openlist` | OpenList网盘挂载 | 几乎可以挂载世面上的所有网盘以及本地磁盘 |
| `luci-app-p910nd` | 网络打印机服务 | 支持远程网络打印（LPR协议）。 |
| `luci-app-radicale2` | Radicale日历服务器 | 轻量级CalDAV/CardDAV服务器。 |
| `luci-app-rclone` | Rclone云存储 | 挂载Google Drive/OneDrive等云盘。 |
| `luci-app-samba4` | Samba4文件共享 | 提供Windows兼容的网络文件共享（SMB协议）。 |
| `luci-app-syncthing` | Syncthing同步工具 | 分布式文件同步（类似Resilio Sync）。 |
| `luci-app-usb-printer` | USB打印机共享 | 将USB打印机转为网络打印机。 |
| `luci-app-vsftpd` | VSFTPD文件服务器 | FTP服务器工具（支持匿名登录）。 |

## 下载/媒体/娱乐

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-airplay2` | AirPlay2接收器 | 将路由器变为AirPlay2音频接收设备。 |
| `luci-app-amule` | aMule电驴下载 | eDonkey/Kad网络P2P下载工具。 |
| `luci-app-aria2` | Aria2下载器 | 支持HTTP/BT/Magnet的多线程下载工具。 |
| `luci-app-dump1090` | Dump1090航空信号接收 | 接收飞机ADS-B信号（需硬件支持）。 |
| `luci-app-minidlna` | MiniDLNA媒体服务器 | DLNA协议流媒体共享（视频/音乐）。 |
| `luci-app-mjpg-streamer` | MJPG视频流 | 将USB摄像头转为网络视频流。 |
| `luci-app-msd_lite` | MSD Lite流媒体 | 高效能的UPnP流媒体服务器。 |
| `luci-app-music-remote-center` | 音乐远程控制 | 远程控制音乐播放器（如MPD）。 |
| `luci-app-oscam` | OSCAM智能卡服务 | 数字电视智能卡共享服务。 |
| `luci-app-ps3netsrv` | PS3网络共享 | 为PS3游戏机提供文件共享服务。 |
| `luci-app-qbittorrent` | qBittorrent下载 | 集成qBittorrent的BT下载工具。 |
| `luci-app-spotifyd` | Spotify音乐播放器 | 轻量级Spotify客户端（命令行版）。 |
| `luci-app-transmission` | Transmission下载 | 集成Transmission的BT下载工具。 |
| `luci-app-unblockneteasemusic` | 解锁网易云音乐 | 绕过网易云音乐地域限制。 |

## 监控/统计/通知

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-apinger` | 网络延迟监控 | 实时监测Ping延迟和丢包率。 |
| `luci-app-chrony` | Chrony时间同步 | 高精度NTP时间同步服务。 |
| `luci-app-email` | 邮件通知工具 | 发送系统状态邮件报警。 |
| `luci-app-netdata` | Netdata性能监控 | 实时系统性能监控仪表盘。 |
| `luci-app-nlbwmon` | 网络带宽监控 | 实时统计设备流量使用情况。 |
| `luci-app-nut` | NUT UPS监控 | 不间断电源（UPS）状态监控。 |
| `luci-app-snmpd` | SNMP监控服务 | 提供SNMP协议的系统监控数据。 |
| `luci-app-statistics` | 统计图表 | 收集并显示CPU/内存/流量等数据。 |
| `luci-app-vnstat2` | VnStat流量统计 | 监控网络流量使用情况（新版）。 |
| `luci-app-watchcat` | 看门狗监控 | 检测网络故障并自动重启。 |
| `luci-app-wechatpush` | 微信推送通知 | 通过Server酱等发送路由器状态到微信。 |

## 安全与防护

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-arpbind` | ARP绑定 | 防止ARP欺骗攻击（绑定IP与MAC）。 |
| `luci-app-banip` | IP封禁工具 | 动态封禁恶意IP地址。 |
| `luci-app-bcp38` | BCP38防IP伪造 | 防止伪造源IP的网络攻击。 |
| `luci-app-clamav` | ClamAV杀毒 | 轻量级病毒扫描工具。 |
| `luci-app-crowdsec-firewall-bouncer` | CrowdSec防火墙防护 | 集成CrowdSec的实时威胁防御。 |
| `luci-app-fwknopd` | Fwknopd单包授权 | 增强SSH等服务的访问安全。 |

## 容器与虚拟化

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-docker` | Docker容器支持 | 基础Docker容器管理功能。 |
| `luci-app-dockerman` | Docker图形管理 | 增强版Docker Web管理界面。 |
| `luci-app-lxc` | LXC容器管理 | 轻量级Linux容器管理工具。 |

## 硬件/外设/物联网

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-3cat` | 3CAT工具 | 提供3CAT服务集成（具体功能需查证）。 |
| `luci-app-3ginfo-lite` | 3G/4G信息精简版 | 显示移动网络模块状态（信号强度、流量等）。 |
| `luci-app-k3screenctrl` | K3屏幕控制 | 管理斐讯K3路由器的OLED屏幕。 |
| `luci-app-ledtrig-rssi` | LED信号强度触发 | 根据WiFi信号强度控制LED灯。 |
| `luci-app-ledtrig-switch` | LED开关触发 | 根据网络开关状态控制LED。 |
| `luci-app-ledtrig-usbport` | LED USB设备触发 | USB设备插入时触发LED灯。 |
| `luci-app-lorawan-basicstation` | LoRaWAN基站 | 支持LoRaWAN物联网网关。 |
| `luci-app-modemband` | 调制解调器频段控制 | 管理4G/5G模块的频段锁定。 |
| `luci-app-mosquitto` | Mosquitto MQTT | MQTT消息代理服务器（物联网协议）。 |
| `luci-app-oled` | OLED屏幕控制 | 管理路由器的OLED显示屏（如R2S）。 |
| `luci-app-ser2net` | 串口转网络工具 | 将串口设备（如单片机）转为TCP/IP访问。 |
| `luci-app-sms-tool-js` | 短信工具（JS版） | 通过USB调制解调器发送/接收短信。 |

## 校园网/认证/运营商相关

| 包名 | 中文名 | 作用说明 |
|---|---|---|
| `luci-app-bitsrunlogin-go` | 比特校园网认证 | 用于校园网认证（如Dr.COM）。 |
| `luci-app-mentohust` | MentoHUST认证 | 校园网锐捷认证客户端。 |
| `luci-app-njitclient` | 南京校园网认证 | 南京地区校园网认证客户端。 |
| `luci-app-scutclient` | 华南理工校园网认证 | 华南理工大学校园网认证客户端。 |
| `luci-app-sysuh3c` | 中山大学校园网认证 | 中山大学H3C认证客户端。 |
| `luci-app-ua2f` | UA2F防火墙工具 | 修改User-Agent以绕过检测（如校园网）。 |
| `luci-app-xlnetacc` | 迅雷快鸟加速 | 通过迅雷快鸟提升宽带速度（需会员）。 |

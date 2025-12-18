# OpenWrt / ImmortalWrt 常用插件清单（按功能分类）

> 说明：OpenWrt/ImmortalWrt 的包数量非常大，这里给一个**实用取向**的分类清单（可作为你自定义固件的“点菜菜单”）。
> - LuCI 插件一般以 `luci-app-xxx` 命名
> - 中文包一般为 `luci-i18n-xxx-zh-cn`
> - 建议“按需加”，避免固件臃肿、占用闪存/内存

---

## 1) Web 管理与系统基础
- LuCI：`luci`、`luci-ssl-openssl`
- 软件包管理：`luci-app-package-manager`
- 防火墙：`luci-app-firewall`
- Web 终端：`luci-app-ttyd`
- 系统工具：`htop`、`nano`、`tcpdump`

## 2) 代理/科学上网（按需选择）
- Passwall：`luci-app-passwall`（建议配中文：`luci-i18n-passwall-zh-cn`）
- OpenClash：`luci-app-openclash`（功能强，体积也大）
- HomeProxy：`luci-app-homeproxy`（较新方案，视上游支持情况）

## 3) DNS / 广告过滤 / 分流
- SmartDNS：`luci-app-smartdns`
- Adblock：`luci-app-adblock`
- Adblock-Fast：`luci-app-adblock-fast`
- PBR（策略路由）：`luci-app-pbr`

## 4) VPN / 组网
- WireGuard：`luci-app-wireguard`、`wireguard-tools`
- OpenVPN：`luci-app-openvpn`、`openvpn-openssl`
- ZeroTier：`luci-app-zerotier`、`zerotier`

## 5) 多拨/负载/网络增强
- MWAN3：`luci-app-mwan3`
- SQM（抗缓冲膨胀）：`luci-app-sqm`
- UPnP：`luci-app-upnp`

## 6) 存储与共享
- Samba4：`luci-app-samba4`
- NFS：`luci-app-nfs`
- 轻量文件管理：`luci-app-filemanager`（或其他你喜欢的）

## 7) 容器与应用
- Docker：`docker` / `dockerd`
- Dockerman：`luci-app-dockerman`

## 8) 监控与统计
- 统计图表：`luci-app-statistics`（依赖 collectd）
- 流量统计：`luci-app-nlbwmon`、`luci-app-vnstat2`

---

## 与本仓库的对应关系（自定义“点菜”）
- 默认包：`config/presets/default.txt`
- 功能组：`config/groups/*.txt`
- 构建时指定：
  - `groups`: 例如 `dns smartdns sqm wireguard`
  - `extra_packages`: 例如 `htop tcpdump`
  - `remove_packages`: 例如 `-ppp -pppoe`


# ImmortalWrt NanoPi R2S 

![Build](https://github.com/MZRidaz/Nanopi-R2S-Openwrt/actions/workflows/build-r2s.yml/badge.svg)
![Release](https://img.shields.io/github/v/release/MZRidaz/Nanopi-R2S-Openwrt?display_name=tag&sort=semver)
![Downloads](https://img.shields.io/github/downloads/MZRidaz/Nanopi-R2S-Openwrt/total)
![License](https://img.shields.io/github/license/MZRidaz/Nanopi-R2S-Openwrt)

## 目录

- [默认配置](#默认配置)
- [一键推荐方案](#一键推荐方案)
- [Actions 友好菜单（勾选功能组）](#actions-友好菜单勾选功能组)
- [高级自定义（包清单）](#高级自定义包清单)
- [固件下载与刷写](#固件下载与刷写)
- [插件清单（按功能分类）](#插件清单按功能分类)
- [FAQ](#faq)
- [参考与致谢](#参考与致谢)
- [License](#license)

---

## 默认配置

| 项目     | 默认值                             |
| -------- | ---------------------------------- |
| 设备     | FriendlyARM NanoPi R2S             |
| 目标平台 | rockchip/armv8                     |
| Profile  | friendlyarm_nanopi-r2s             |
| 管理 IP  | `192.168.2.1`                      |
| 默认密码 | `password`                         |
| Web 管理 | LuCI（含 HTTPS）                   |
| 代理插件 | Passwall（含中文 i18n）            |
| 构建方式 | ImmortalWrt 官方 ImageBuilder      |
| 发布产物 | Releases（仅 `sysupgrade.img.gz`） |

> ⚠️ 安全提示：刷机后请尽快修改默认密码。

---

## 一键推荐方案

> 下面都是在 Actions 的 Run workflow 页面勾选功能组即可（必要时再补 `extra_packages/remove_packages`）

### ✅ 1) 轻量旁路由（推荐默认）
- 勾选：无（只保留默认 LuCI + Passwall 中文）
- 说明：体积小、稳定，适合旁路由或主路由轻量化

### ✅ 2) 家用增强（DNS + 终端 + IPv6）
- 勾选：SmartDNS / DNS(广告过滤) / ttyd / IPv6
- 可选 extra：`htop tcpdump`

### ✅ 3) 游戏/直播优化（抗缓冲膨胀）
- 勾选：SQM
- 说明：对上行拥堵场景更友好（需按你带宽调参）

### ✅ 4) 远程回家（组网）
- 勾选：WireGuard 或 ZeroTier（二选一）
- 说明：按你的网络环境选择更合适的组网方案

### ✅ 5) 存储共享（轻 NAS）
- 勾选：Samba4
- 说明：建议配合外接存储，注意 R2S 性能/供电

---

## Actions 友好菜单（勾选功能组）

在 `Run workflow` 页面，直接通过 **checkbox 开关**选择功能组（会映射到 `config/groups/*.txt`）：

- DNS/广告过滤（adblock / adblock-fast）
- SmartDNS
- SQM
- WireGuard
- ZeroTier
- Docker + Dockerman
- Samba4
- OpenVPN
- 监控统计
- Web 终端（ttyd）
- IPv6 常用组件

同时保留高级输入：
- `extra_packages`：额外安装包（空格分隔），如 `htop tcpdump`
- `remove_packages`：移除包（空格分隔，包名前加 `-`），如 `-ppp -pppoe`
- `force`：强制构建（忽略“上游未更新则跳过”）

---

## 高级自定义（包清单）

> 如果你希望“配置即代码”，把选择固化到仓库里：

- 默认包清单：`config/presets/default.txt`
- 功能组包清单：`config/groups/*.txt`
- overlay（首次启动配置）：`files/`

### 新增一个自己的功能组（示例）
1. 新建 `config/groups/mygroup.txt`
2. 写入你要安装的包名（每行一个）
3. 在工作流里增加一个 checkbox，并在 `Compose groups` 步骤里拼上 `mygroup`

---

## 固件下载与刷写

Releases 中只发布 **刷机用固件**（一般为 `*sysupgrade.img.gz`）。

常见刷写方式（根据你的使用场景选择）：
- **从 OpenWrt/ImmortalWrt 系统内升级**：LuCI → 系统 → 备份/升级 → 上传 `sysupgrade` 固件
- **从 PC 写盘**：解压后使用 `balenaEtcher` / `Rufus` 写入 TF 卡或 U 盘  
- **命令行 dd（谨慎）**：确认设备路径无误再写入（避免写错盘）

> 提示：升级前建议备份配置；跨大版本升级更建议不保留配置。

---

## 插件清单（按功能分类）

> OpenWrt/ImmortalWrt 包非常多，这里列常用“点菜菜单”。  
> - LuCI 插件：`luci-app-xxx`
> - 中文包：`luci-i18n-xxx-zh-cn`
> - 建议按需添加，保持系统精简与稳定

<details>
<summary><b>1) Web 管理与系统基础</b></summary>

- LuCI：`luci`、`luci-ssl-openssl`
- 软件包管理：`luci-app-package-manager`
- 防火墙：`luci-app-firewall`
- Web 终端：`luci-app-ttyd`
- 常用工具：`htop`、`nano`、`tcpdump`

</details>

<details>
<summary><b>2) 代理 / 分流（按需选择）</b></summary>

- Passwall：`luci-app-passwall`（中文：`luci-i18n-passwall-zh-cn`）
- OpenClash：`luci-app-openclash`（功能强但体积大）
- HomeProxy：`luci-app-homeproxy`（新方案，视上游支持情况）

</details>

<details>
<summary><b>3) DNS / 广告过滤 / 分流</b></summary>

- SmartDNS：`luci-app-smartdns`（中文：`luci-i18n-smartdns-zh-cn`）
- Adblock：`luci-app-adblock`
- Adblock-Fast：`luci-app-adblock-fast`
- PBR（策略路由）：`luci-app-pbr`

</details>

<details>
<summary><b>4) VPN / 组网</b></summary>

- WireGuard：`luci-app-wireguard`、`wireguard-tools`
- OpenVPN：`luci-app-openvpn`、`openvpn-openssl`
- ZeroTier：`luci-app-zerotier`、`zerotier`

</details>

<details>
<summary><b>5) 多拨 / 负载 / 网络增强</b></summary>

- MWAN3：`luci-app-mwan3`
- SQM：`luci-app-sqm`（中文：`luci-i18n-sqm-zh-cn`）
- UPnP：`luci-app-upnp`

</details>

<details>
<summary><b>6) 存储与共享</b></summary>

- Samba4：`luci-app-samba4`（中文：`luci-i18n-samba4-zh-cn`）
- NFS：`luci-app-nfs`
- 文件管理：`luci-app-filemanager`（或其他你习惯的）

</details>

<details>
<summary><b>7) 容器与应用</b></summary>

- Docker：`docker` / `dockerd`
- Dockerman：`luci-app-dockerman`

</details>

<details>
<summary><b>8) 监控与统计</b></summary>

- 统计图表：`luci-app-statistics`（依赖 collectd）
- 流量统计：`luci-app-nlbwmon`、`luci-app-vnstat2`

</details>

---

## FAQ

### Q1：为什么定时任务没跑？
- 需要启用 Actions，并且 GitHub 对 schedule 有自身调度策略（手动触发最可靠）
- 你也可以随时在 Actions 里点 **Run workflow**

### Q2：为什么定时不构建？
- 这是特性：脚本会检查上游是否更新
- Upstream-ID 未变化会自动跳过（避免重复 Release）

### Q3：为什么某些包构建失败/找不到？
- 上游 feed 可能随版本调整包名或组件拆分
- 建议先减少勾选功能组，确认基础可用后再逐步加包

### Q4：如何保持固件更精简？
- 少勾选功能组
- 用 `remove_packages` 移除不需要的组件
- 避免一次性装太多 LuCI 应用（尤其是 docker/openclash 等大件）

---

## 参考与致谢

- https://github.com/QiuSimons/YAOF
- https://github.com/stupidloud/nanopi-openwrt

---

## License

MIT

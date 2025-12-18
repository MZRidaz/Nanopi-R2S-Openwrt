# ImmortalWrt NanoPi R2S 固件自动构建（ImageBuilder）

本仓库使用 **ImmortalWrt 官方 ImageBuilder** 为 **FriendlyARM NanoPi R2S（rockchip/armv8）** 生成刷机固件，并通过 GitHub Actions：
- **手动触发编译**
- **北京时间每周六 02:00 自动触发**（GitHub Actions 用 UTC 计时，对应 cron：周五 18:00 UTC）
- **若 ImmortalWrt 无更新则跳过自动编译**
- 编译完成后自动发布到 **Releases**（只上传刷机固件文件）

> 参考思路：YAOF / nanopi-openwrt 等项目（可在你的仓库 README 中加上来源说明即可）。

---

## 默认设置

- **默认管理 IP**：`192.168.2.1`
- **默认密码**：`password`
- **默认包含**：LuCI + Passwall（含中文 i18n），尽量精简但可用。

> Passwall 在 ImmortalWrt 24.10.4 的 LuCI feed 中提供（luci-app-passwall）。  

---

## 使用方式

1. Fork 本仓库到你的 GitHub
2. 进入仓库 → **Settings → Actions → General**，确保允许 Actions 运行
3. 进入 **Actions → Build ImmortalWrt R2S (ImageBuilder)**：
   - 点击 **Run workflow** 手动构建
4. 构建完成后到 **Releases** 下载固件（`.img.gz`）

---

## 自定义安装插件（两种方式）

### 方式 A：Run workflow 时临时指定（推荐）
在 **Run workflow** 输入：
- `groups`：使用预设功能组（空格分隔），例如：`dns smartdns sqm`
- `extra_packages`：额外包（空格分隔），例如：`htop tcpdump`
- `remove_packages`：要移除的包（空格分隔），例如：`-ppp -pppoe`

### 方式 B：修改仓库内的包清单
- 默认包清单：`config/presets/default.txt`
- 预设功能组：`config/groups/*.txt`（你可以自己新增/修改）

---

## 目录结构

- `.github/workflows/build-r2s.yml`：CI 流水线
- `scripts/resolve.sh`：自动选择最新 ImmortalWrt 版本/快照，并决定是否需要构建
- `scripts/build.sh`：下载 ImageBuilder、组装包列表、生成固件
- `files/`：固件 overlay（首次启动时设置 IP/密码/语言等）
- `config/`：默认包、可选功能组
- `docs/plugins.md`：OpenWrt/ImmortalWrt 常用插件清单（按功能分类）

---

## 说明

- GitHub Actions 的定时任务使用 UTC，已按北京时间换算：周六 02:00（北京）= 周五 18:00（UTC）。
- 自动构建时会检测上游版本（或快照 build 标识）是否变化；若没变则跳过，避免重复发布。


# ImmortalWrt NanoPi R2S

## 默认设置

- **默认管理 IP**：`192.168.2.1`
- **默认密码**：`password` 

---

## 使用方式

1. Fork 本仓库到你的 GitHub
2. 进入仓库 → **Settings → Actions → General**，确保允许 Actions 运行
3. 进入 **Actions → Build ImmortalWrt R2S (ImageBuilder)**：
   - 点击 **Run workflow** 手动构建
4. 构建完成后到 **Releases** 下载固件（`.img.gz`）

---

## 自定义安装插件（两种方式）

`docs/plugins.md`：OpenWrt/ImmortalWrt 常用插件清单

### 1：Run workflow 时临时指定（推荐）
在 **Run workflow** 输入：
- `groups`：使用预设功能组（空格分隔），例如：`dns smartdns sqm`
- `extra_packages`：额外包（空格分隔），例如：`htop tcpdump`
- `remove_packages`：要移除的包（空格分隔），例如：`-ppp -pppoe`

### 2：修改仓库内的包清单
- 默认包清单：`config/presets/default.txt`
- 预设功能组：`config/groups/*.txt`（你可以自己新增/修改）


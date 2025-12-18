#!/usr/bin/env bash
set -euo pipefail

CHANNEL="${CHANNEL:-stable}"
UPSTREAM_VERSION="${UPSTREAM_VERSION:-}"
UPSTREAM_ID="${UPSTREAM_ID:-}"
IMAGEBUILDER_URL="${IMAGEBUILDER_URL:-}"
TARGET="${TARGET:-rockchip/armv8}"
PROFILE="${PROFILE:-friendlyarm_nanopi-r2s}"

GROUPS="${GROUPS:-}"
EXTRA_PACKAGES="${EXTRA_PACKAGES:-}"
REMOVE_PACKAGES="${REMOVE_PACKAGES:-}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKDIR="$ROOT_DIR/workdir"
EXTRACT_DIR="$WORKDIR/extract"

mkdir -p "$WORKDIR"
rm -rf "$EXTRACT_DIR"
mkdir -p "$EXTRACT_DIR"

echo "Downloading ImageBuilder:"
echo "$IMAGEBUILDER_URL"

archive="$WORKDIR/$(basename "$IMAGEBUILDER_URL")"
rm -f "$archive"
curl -fL "$IMAGEBUILDER_URL" -o "$archive"

echo "Extracting..."
if [[ "$archive" == *.tar.zst ]]; then
  tar --zstd -xf "$archive" -C "$EXTRACT_DIR"
elif [[ "$archive" == *.tar.xz ]]; then
  tar -xJf "$archive" -C "$EXTRACT_DIR"
else
  echo "ERROR: unknown archive suffix: $archive" >&2
  exit 1
fi

# 自动定位 ImageBuilder 根目录：找到包含 image: 目标的 Makefile
IB_DIR=""
while IFS= read -r mf; do
  if grep -qE '^[[:space:]]*image:' "$mf"; then
    IB_DIR="$(dirname "$mf")"
    break
  fi
done < <(find "$EXTRACT_DIR" -maxdepth 3 -type f -name Makefile | sort)

if [[ -z "$IB_DIR" ]]; then
  echo "ERROR: cannot locate ImageBuilder root (Makefile with 'image:' target not found)" >&2
  echo "DEBUG: extracted top-level dirs:" >&2
  find "$EXTRACT_DIR" -maxdepth 2 -type d -print >&2 || true
  exit 1
fi

echo "ImageBuilder root: $IB_DIR"
echo "Preparing overlay files..."

OVERLAY="$ROOT_DIR/files"
test -d "$OVERLAY"

# 收集 packages（默认 preset + groups + extra/remove）
export GROUPS EXTRA_PACKAGES REMOVE_PACKAGES
PACKAGES="$(bash "$ROOT_DIR/scripts/collect_packages.sh" default)"
echo "Packages: $PACKAGES"

pushd "$IB_DIR" >/dev/null

# 打印一些 info，方便排查 PROFILE / feeds 等（不影响构建）
echo "== make info (first 60 lines) =="
make info | head -n 60 || true
echo "================================"

# 构建固件
make image PROFILE="$PROFILE" PACKAGES="$PACKAGES" FILES="$OVERLAY"

popd >/dev/null

# 输出目录
OUTDIR="$IB_DIR/bin/targets/${TARGET}"
if [[ ! -d "$OUTDIR" ]]; then
  echo "ERROR: output dir not found: $OUTDIR" >&2
  find "$IB_DIR/bin" -maxdepth 5 -type d -print || true
  exit 1
fi

# 优先 sysupgrade 的 img.gz
firmware="$(ls -1 "$OUTDIR"/*nanopi-r2s*sysupgrade*.img.gz 2>/dev/null | head -n 1 || true)"
if [[ -z "$firmware" ]]; then
  firmware="$(ls -1 "$OUTDIR"/*nanopi-r2s*.img.gz 2>/dev/null | head -n 1 || true)"
fi
if [[ -z "$firmware" ]]; then
  echo "ERROR: cannot locate firmware image in $OUTDIR" >&2
  ls -la "$OUTDIR" || true
  exit 1
fi

echo "Done: $firmware"

# Release 信息
id_short="${UPSTREAM_ID:0:12}"
if [[ "$CHANNEL" == "snapshot" ]]; then
  release_tag="immortalwrt-${UPSTREAM_VERSION}-${id_short}-r2s"
else
  release_tag="immortalwrt-${UPSTREAM_VERSION}-r2s"
fi
release_name="ImmortalWrt ${UPSTREAM_VERSION} NanoPi R2S"

release_body=$(
  cat <<EOF
Target: ${TARGET}
Profile: ${PROFILE}
Channel: ${CHANNEL}
Upstream-Version: ${UPSTREAM_VERSION}
Upstream-ID: ${UPSTREAM_ID}

默认管理IP：192.168.2.1
默认密码：password
默认包含：LuCI + Passwall（含中文）
EOF
)

# 写 GitHub Actions outputs（修复多行 delimiter 报错：使用随机分隔符）
echo "firmware_path=$firmware" >> "$GITHUB_OUTPUT"
echo "release_tag=$release_tag" >> "$GITHUB_OUTPUT"
echo "release_name=$release_name" >> "$GITHUB_OUTPUT"

DELIM="__RELEASE_BODY_$(date +%s%N)__"
{
  echo "release_body<<$DELIM"
  echo "$release_body"
  echo "$DELIM"
} >> "$GITHUB_OUTPUT"

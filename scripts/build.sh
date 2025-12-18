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
IB_DIR="$WORKDIR/imagebuilder"

mkdir -p "$WORKDIR"
rm -rf "$IB_DIR"
mkdir -p "$IB_DIR"

echo "Downloading ImageBuilder:"
echo "$IMAGEBUILDER_URL"

archive="$WORKDIR/$(basename "$IMAGEBUILDER_URL")"
curl -fL "$IMAGEBUILDER_URL" -o "$archive"

echo "Extracting..."
mkdir -p "$WORKDIR/extract"
rm -rf "$WORKDIR/extract"/*
if [[ "$archive" == *.tar.zst ]]; then
  tar --zstd -xf "$archive" -C "$WORKDIR/extract"
elif [[ "$archive" == *.tar.xz ]]; then
  tar -xJf "$archive" -C "$WORKDIR/extract"
else
  echo "ERROR: unknown archive suffix: $archive" >&2
  exit 1
fi

# imagebuilder dir name varies; pick first directory
IB_SRC="$(find "$WORKDIR/extract" -maxdepth 1 -type d -name '*imagebuilder*' | head -n 1)"
if [[ -z "$IB_SRC" ]]; then
  echo "ERROR: cannot find imagebuilder directory after extraction" >&2
  exit 1
fi
mv "$IB_SRC" "$IB_DIR"

echo "Preparing overlay files..."
# ensure overlay exists
OVERLAY="$ROOT_DIR/files"
test -d "$OVERLAY"

# Collect packages
export GROUPS EXTRA_PACKAGES REMOVE_PACKAGES
PACKAGES="$(bash "$ROOT_DIR/scripts/collect_packages.sh" default)"
echo "Packages: $PACKAGES"

pushd "$IB_DIR" >/dev/null

# Build
make image PROFILE="$PROFILE" PACKAGES="$PACKAGES" FILES="$OVERLAY"

popd >/dev/null

# Find firmware
OUTDIR="$IB_DIR/bin/targets/${TARGET}"
if [[ ! -d "$OUTDIR" ]]; then
  echo "ERROR: output dir not found: $OUTDIR" >&2
  find "$IB_DIR/bin" -maxdepth 4 -type d || true
  exit 1
fi

# Prefer sysupgrade img.gz
firmware="$(ls -1 "$OUTDIR"/*nanopi-r2s*sysupgrade*.img.gz 2>/dev/null | head -n 1 || true)"
if [[ -z "$firmware" ]]; then
  # fallback: any img.gz for r2s
  firmware="$(ls -1 "$OUTDIR"/*nanopi-r2s*.img.gz 2>/dev/null | head -n 1 || true)"
fi
if [[ -z "$firmware" ]]; then
  echo "ERROR: cannot locate firmware image in $OUTDIR" >&2
  ls -la "$OUTDIR" || true
  exit 1
fi

# Release metadata
id_short="${UPSTREAM_ID:0:12}"
if [[ "$CHANNEL" == "snapshot" ]]; then
  release_tag="immortalwrt-${UPSTREAM_VERSION}-${id_short}-r2s"
else
  release_tag="immortalwrt-${UPSTREAM_VERSION}-r2s"
fi
release_name="ImmortalWrt ${UPSTREAM_VERSION} NanoPi R2S"

# Release body (store upstream id for next scheduled skip check)
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

echo "firmware_path=$firmware" >> "$GITHUB_OUTPUT"
echo "release_tag=$release_tag" >> "$GITHUB_OUTPUT"
echo "release_name=$release_name" >> "$GITHUB_OUTPUT"
# multiline output
{
  echo "release_body<<'EOF'"
  echo "$release_body"
  echo "EOF"
} >> "$GITHUB_OUTPUT"

echo "Done: $firmware"

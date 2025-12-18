#!/usr/bin/env bash
set -euo pipefail

CHANNEL="${CHANNEL:-stable}"
EVENT_NAME="${EVENT_NAME:-}"
FORCE_BUILD="${FORCE_BUILD:-false}"

BASE_URL="https://downloads.immortalwrt.org"
TARGET="rockchip/armv8"
PROFILE="friendlyarm_nanopi-r2s"

echo "channel=$CHANNEL" >> "$GITHUB_OUTPUT"
echo "target=$TARGET" >> "$GITHUB_OUTPUT"
echo "profile=$PROFILE" >> "$GITHUB_OUTPUT"

fetch_index() {
  curl -fsSL "$1"
}

pick_latest_stable_version() {
  # 解析 releases/ 目录下的 x.y.z 版本号，按版本排序取最大
  fetch_index "$BASE_URL/releases/" \
    | grep -oE 'href="[0-9]+\.[0-9]+\.[0-9]+/' \
    | sed -E 's/^href="|\/$//g' \
    | sort -V \
    | tail -n 1
}

pick_latest_snapshot_branch() {
  # 解析 releases/ 目录下的 *-SNAPSHOT 分支，按前缀版本号排序取最大
  fetch_index "$BASE_URL/releases/" \
    | grep -oE 'href="[0-9]+\.[0-9]+-SNAPSHOT/' \
    | sed -E 's/^href="|\/$//g' \
    | sort -V \
    | tail -n 1
}

find_imagebuilder_url() {
  local rel="$1"
  local target_dir="$BASE_URL/releases/${rel}/targets/${TARGET}/"
  local sha_url="${target_dir}sha256sums"

  local ib_name=""

  # 优先从 sha256sums 解析（更稳定）
  # 注意：sha256sums 的文件名可能以 '*' 开头（GNU checksum 二进制标识），必须去掉
  if curl -fsSL "$sha_url" >/dev/null 2>&1; then
    ib_name="$(curl -fsSL "$sha_url" \
      | awk '{print $2}' \
      | sed 's/^\*//' \
      | grep -E '^immortalwrt-imagebuilder-.*\.tar\.(zst|xz)$' \
      | head -n 1 || true)"
  fi

  # fallback：从目录 index 解析
  if [[ -z "$ib_name" ]]; then
    ib_name="$(fetch_index "$target_dir" \
      | grep -oE 'immortalwrt-imagebuilder-[^"]+\.tar\.(zst|xz)' \
      | head -n 1 || true)"
  fi

  if [[ -z "$ib_name" ]]; then
    echo "ERROR: cannot find imagebuilder in $target_dir" >&2
    return 1
  fi

  echo "${target_dir}${ib_name}"
}

calc_upstream_id() {
  # 使用 version.buildinfo 内容作为“上游标识”，适合 stable & snapshot（snapshot 会频繁变化）
  local rel="$1"
  local url="$BASE_URL/releases/${rel}/targets/${TARGET}/version.buildinfo"
  if curl -fsSL "$url" >/dev/null 2>&1; then
    curl -fsSL "$url" | sha256sum | awk '{print $1}'
  else
    # fallback：没有 buildinfo 时，stable 用版本号
    echo "$rel"
  fi
}

latest_release_upstream_id() {
  # 从本仓库最新 Release body 中提取 Upstream-ID
  # 若没有 release，则返回空串
  local body
  body="$(gh api "repos/${GITHUB_REPOSITORY}/releases/latest" --jq '.body' 2>/dev/null || true)"
  if [[ -z "$body" ]]; then
    echo ""
    return 0
  fi
  echo "$body" | sed -nE 's/^Upstream-ID:[[:space:]]*([a-f0-9]+).*/\1/p' | head -n 1
}

main() {
  local rel=""
  if [[ "$CHANNEL" == "snapshot" ]]; then
    rel="$(pick_latest_snapshot_branch)"
    if [[ -z "$rel" ]]; then
      echo "ERROR: cannot find snapshot branch under releases/." >&2
      exit 1
    fi
  else
    rel="$(pick_latest_stable_version)"
    if [[ -z "$rel" ]]; then
      echo "ERROR: cannot find stable version under releases/." >&2
      exit 1
    fi
  fi

  local ib_url
  ib_url="$(find_imagebuilder_url "$rel")"

  local upstream_id
  upstream_id="$(calc_upstream_id "$rel")"

  echo "version=$rel" >> "$GITHUB_OUTPUT"
  echo "imagebuilder_url=$ib_url" >> "$GITHUB_OUTPUT"
  echo "upstream_id=$upstream_id" >> "$GITHUB_OUTPUT"

  local skip="false"
  if [[ "$EVENT_NAME" == "schedule" && "$FORCE_BUILD" != "true" ]]; then
    local last_id
    last_id="$(latest_release_upstream_id)"
    if [[ -n "$last_id" && "$last_id" == "$upstream_id" ]]; then
      skip="true"
    fi
  fi

  echo "skip=$skip" >> "$GITHUB_OUTPUT"
  if [[ "$skip" == "true" ]]; then
    echo "Upstream not updated. Skip build."
  else
    echo "Will build: version=$rel upstream_id=$upstream_id"
    echo "ImageBuilder: $ib_url"
  fi
}

main

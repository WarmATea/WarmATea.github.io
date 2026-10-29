#!/usr/bin/env bash
# 发布博客：提交所有改动并推送到 GitHub
# 用法：bash publish.sh "提交说明"（说明可省略）
set -euo pipefail

cd "$(dirname "$0")"

if git diff --quiet && git diff --cached --quiet; then
  echo "没有需要提交的改动"
  exit 0
fi

MSG="${1:-$(date '+%Y-%m-%d %H:%M 更新')}"

git add -A
git commit -m "$MSG"
git push
echo "✅ 已推送，等 2~3 分钟上线"

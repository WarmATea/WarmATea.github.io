#!/usr/bin/env bash
# 新建一篇博客文章（自动设置 draft=false、标题、发布时间）
# 用法：bash newpost.sh <板块> <标题> [英文文件名]
#   板块：daily(日常)  tech(技术)  memo(备忘录)
# 例子：
#   bash newpost.sh tech 雕版机维修 diaobanji-weixiu
#   bash newpost.sh memo "今天的小记"        （不写文件名则自动用时间戳）
set -euo pipefail

cd "$(dirname "$0")"

SECTION="${1:-}"
TITLE="${2:-}"
SLUG="${3:-}"

case "$SECTION" in
  daily|tech|memo) ;;
  *)
    echo "用法：bash newpost.sh <daily|tech|memo> <标题> [英文文件名]"
    echo "例如：bash newpost.sh tech 雕版机维修 diaobanji-weixiu"
    exit 1
    ;;
esac

if [ -z "$TITLE" ]; then
  echo "❌ 缺少标题。例如：bash newpost.sh memo 今天的小记"
  exit 1
fi

if [ -z "$SLUG" ]; then
  SLUG="$(date +%Y%m%d-%H%M%S)"
fi

FILE="content/$SECTION/$SLUG.md"
mkdir -p "content/$SECTION"

cat > "$FILE" <<EOF
+++
date = '$(date -Iseconds)'
draft = false
title = '$TITLE'
+++

<!-- 在这里写正文 -->
EOF

echo "✅ 已创建：$FILE"
echo "   写完正文后运行：bash publish.sh \"提交说明\""

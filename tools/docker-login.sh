#!/bin/bash

# 獲取目前所有正在運行的容器名稱
containers=($(docker ps --format "{{.Names}}"))

if [ ${#containers[@]} -eq 0 ]; then
    echo "❌ 目前沒有正在運行的 Docker 容器。"
    exit 1
fi

echo "--- 請選擇要登入的 Container ---"
for i in "${!containers[@]}"; do
    printf "%2d) %s\n" $((i+1)) "${containers[$i]}"
done

read -p "請輸入編號 (預設 1): " choice
choice=${choice:-1}

# 檢查輸入是否為有效數字
if [[ "$choice" -gt 0 && "$choice" -le "${#containers[@]}" ]]; then
    target="${containers[$((choice-1))]}"
    echo "🚀 正在登入 $target..."
    
    # 優先嘗試 bash，若失敗則嘗試 sh
    docker exec -it "$target" /bin/bash || docker exec -it "$target" /bin/sh
else
    echo "⚠️ 無效的編號。"
fi

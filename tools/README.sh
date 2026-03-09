#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Module Purpose: 自動掃描源碼並生成專業 README.md (v1.1.21)
# Author: Gemini CLI (Senior Systems Engineer)
# License: MIT
# Changelog:
# 2026-03-09: v1.1.21 - 強制重寫以修復自主代理造成的邏輯損壞與語法錯誤，恢復穩定掃描機制。
# ==============================================================================

log_info()  { echo -e "[\033[0;32mINFO\033[0m] [\033[0;36m$(date +'%H:%M:%S')\033[0m] [\033[0;35m$$ PID\033[0m] $*"; }
log_error() { echo -e "[\033[0;31mERROR\033[0m] [\033[0;36m$(date +'%H:%M:%S')\033[0m] [\033[0;35m$$ PID\033[0m] $*" >&2; }
bold_text() { echo -en "\033[1m$*\033[0m"; }

main() {
    # 檢查必要命令
    for cmd in realpath mktemp find cat gemini; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            log_error "缺少必要指令: $cmd"; exit 1
        fi
    done

    local output_file="README.md"
    local target_dir="."
    local extensions=()
    local lang_prompt=""
    local overwrite_mode=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -php)    extensions+=("php"); lang_prompt+=" 處理 PHP。" ;;
            -python) extensions+=("py"); lang_prompt+=" 處理 Python。" ;;
            -js)     extensions+=("js"); lang_prompt+=" 處理 JS。" ;;
            -ts)     extensions+=("ts"); lang_prompt+=" 處理 TypeScript。" ;;
            -go)     extensions+=("go"); lang_prompt+=" 處理 Go。" ;;
            -sh)     extensions+=("sh"); lang_prompt+=" 處理 Shell。" ;;
            -linux)   lang_prompt+=" Linux 教學。" ;;
            -windows) lang_prompt+=" Windows 教學。" ;;
            -mac)     lang_prompt+=" Mac 教學。" ;;
            -all)     lang_prompt+=" 全平台 (Linux/Win/Mac) 教學。" ;;
            -y)       overwrite_mode=true ;;
            -o)       output_file="$2"; shift ;;
            -*)       log_error "未知參數: $1"; exit 1 ;;
            *)        target_dir="$1" ;;
        esac
        shift
    done

    [[ ! -d "$target_dir" ]] && { log_error "目錄不存在: $target_dir"; exit 1; }
    local abs_target
    abs_target=$(realpath "$target_dir")
    log_info "正在掃描目錄: $abs_target"

    # 收集檔案 (排除雜訊)
    local ext_pattern="php|py|js|sh|go|ts"
    [[ ${#extensions[@]} -gt 0 ]] && ext_pattern=$(IFS="|"; echo "${extensions[*]}")

    local context_tmp
    context_tmp=$(mktemp)
    trap 'rm -f "${context_tmp:-}"' EXIT

    if [[ "$overwrite_mode" == false && -f "$output_file" ]]; then
        log_info "參考既存 $output_file..."
        { echo -e "--- EXISTING README ---\n"; cat "$output_file"; echo -e "\n--- END ---\n"; } >> "$context_tmp"
    fi

    local count=0
    # 執行檔案收集
    while IFS= read -r f; do
        [[ $count -ge 30 ]] && break
        echo -e "\n--- File: ${f#$abs_target/} ---\n" >> "$context_tmp"
        cat "$f" >> "$context_tmp"
        ((++count))
    done < <(find "$abs_target" -type f \( -name "*.$ext_pattern" \) -not -path "*/.*" -not -path "*/node_modules/*" -not -path "*/vendor/*" | head -n 30)

    [[ $count -eq 0 ]] && { log_error "找不到可供分析的檔案。"; exit 1; }
    log_info "已收集 $count 個檔案。提示詞: $lang_prompt"

    local final_prompt="你是一位專業 Staff Engineer。請根據代碼產出詳細繁體中文 README.md。
要求：
1. 專案名稱
2. 技術棧
3. 全方位安裝教學
4. 使用範例, 完整範例 ，和使用說明
5. 檔案目錄結構
6. Changelog (只增不刪)。
7. 修改 達到 需求功能
8. 最小化 修改 達到需求


${lang_prompt}
直接產出內容，不含開場白。
"

    log_info "產出中..."
    local ret
    set +e
    cat "$context_tmp" | gemini --model gemini-2.5-flash --prompt "$final_prompt" > "$output_file"
    ret=$?
    set -e

    if [[ $ret -eq 0 ]]; then
        echo -e "\n✅ $(bold_text "生成成功！")"
        log_info "路徑: $(realpath "$output_file")"
    else
        log_error "Gemini 產出失敗 (Exit Code: $ret)。"
        exit $ret
    fi
}

main "$@"

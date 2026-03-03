# ai-tools-kit

> **AI 驅動的開發者工具箱**：結合 AI 強大分析能力，提升日常開發流程的自動化與精確度。

---

## 🚀 專案概述

`ai-tools-kit` 是一套專為現代開發者設計的自動化腳本集。目前核心聚焦於 Git 工作流的優化，透過大型語言模型（LLM）分析程式碼異動，產出具備專業性、描述性且符合社群規範的提交訊息。

### 🛠️ 目前收錄工具
- **`git-commit`**: 自動分析 Git Diff，生成符合 Conventional Commits 規範的繁體中文訊息，並支援手動查閱與編輯。

---

## 📦 環境需求

在執行本工具前，請確保您的系統已安裝以下依賴：

1. **Git**: 基本的版本控制工具。
2. **Gemini CLI**: 用於與 Google Gemini 模型互動。
3. **Bash 4.0+**: 支援腳本執行環境。
4. **EDITOR**: 系統環境變數中建議設定預設編輯器（如 `export EDITOR=vim`），否則將預設使用 `vi`。

---

## ⚙️ 安裝與配置

您可以將此倉庫克隆至本地，並將 `tools` 目錄加入您的 `PATH`：

```bash
git clone https://github.com/your-repo/ai-tools-kit.git
cd ai-tools-kit
export PATH="$PATH:$(pwd)/tools"
```

確保腳本具備執行權限：
```bash
chmod +x tools/git-commit
```

---

## 📖 工具詳細使用說明：git-commit

### 1. 功能描述
`git-commit` 腳本會掃描指定路徑下的程式碼變動（Staged 或 Unstaged），調用 Gemini API 生成推薦的提交訊息，並開啟編輯器供您最終確認。

### 2. 命令語法
```bash
git-commit [選項] [--] [路徑...]
```

### 3. 參數說明
| 參數 | 說明 | 預設值 |
| :--- | :--- | :--- |
| `路徑...` | 指定要分析與提交的檔案或目錄。支援多個路徑。 | `.` (當前目錄) |

### 4. 選項說明
| 選項 | 功能描述 |
| :--- | :--- |
| `-v` | **偵錯模式 (Debug mode)**：顯示詳細的執行過程與暫存檔資訊。 |
| `-h` | **顯示說明**：輸出工具的使用幫助訊息。 |

### 5. 使用範例

**對當前目錄所有變動進行 Commit：**
```bash
git-commit
```

**僅針對 `src/` 目錄下的異動進行分析：**
```bash
git-commit src/
```

**針對多個特定檔案產出訊息：**
```bash
git-commit main.py utils.py
```

**開啟偵錯模式查閱 API 互動過程：**
```bash
git-commit -v .
```

---

## 📝 提交訊息規範 (Conventional Commits)

生成的訊息將遵循以下結構：
- `feat`: 新增功能
- `fix`: 修補錯誤
- `docs`: 文件更動
- `style`: 格式異動（不影響程式邏輯）
- `refactor`: 程式碼重構
- `perf`: 效能提升
- `test`: 測試案例
- `chore`: 建置程序或輔助工具變動

---

## 🛡️ 版本紀錄 (Changelog)

### v1.1 (2026-03-03)
- 🚀 **新功能**: 支援指定路徑分析。
- 🛠️ **優化**: 整合編輯器（`$EDITOR`）供二次審查。
- 🐛 **安全性**: 強化錯誤處理機制與依賴檢查。

---

## 📄 授權協議

本專案採用 **MIT License** 授權。

---

### 依賴指令集
```bash
# 確保環境中有 gemini cli (需先配置 API Key)
# https://github.com/google/gemini-cli
# 請參考專案內的 python.md 或相關文件進行安裝
pip install google-gemini-cli
```

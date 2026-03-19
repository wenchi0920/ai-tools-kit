# README Generator CLI (README.sh)

## 專案簡介
`README.sh` 是一個自動化系統工具，專為工程師設計，旨在透過靜態掃描專案目錄並整合 **Gemini AI** 強大的語義分析能力，快速生成具備 Production-Ready 水準的 `README.md`。它能自動識別技術棧，產出包含安裝指南、使用範例、目錄結構及異動紀錄的完整文件。

## 參數說明 (CLI Flags)

| 參數 | 類別 | 功能說明 |
| :--- | :--- | :--- |
| `-php` | 技術棧 | 優先掃描 `.php` 檔案，產出 PHP 相關配置。 |
| `-python` | 技術棧 | 優先掃描 `.py` 檔案，產出 Python/Pip 相關配置。 |
| `-js` | 技術棧 | 優先掃描 `.js` 檔案，產出 Node.js 相關配置。 |
| `-ts` | 技術棧 | 優先掃描 `.ts` 檔案，產出 TypeScript 相關配置。 |
| `-go` | 技術棧 | 優先掃描 `.go` 檔案，產出 Go 相關配置。 |
| `-sh` | 技術棧 | 優先掃描 `.sh` 檔案，產出 Shell 腳本說明。 |
| `-linux` | 教學 | 在 README 中加入 Linux 安裝與操作教學。 |
| `-windows` | 教學 | 在 README 中加入 Windows 安裝與操作教學。 |
| `-mac` | 教學 | 在 README 中加入 macOS 安裝與操作教學。 |
| `-all` | 教學 | 包含 Linux, Windows, Mac 的全方位安裝教學。 |
| `-y` | 模式 | 覆寫模式：略過既存 README，完全根據當前代碼重新生成。 |
| `-o [file]` | 輸出 | 指定產出檔案名稱（預設：`README.md`）。 |


## 提示詞

你是一位專業 Staff Engineer。請根據代碼產出詳細繁體中文 README.md。
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




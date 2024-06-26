
## 簡介
- 本專案為一個任務管理系統
- 以HTML、CSS、JavaScript及Ruby撰寫，為動態網頁
- 設計模式（design pattern）採用MVC架構
- 運用 Reactive Programming 
- 樣式部分以SCSS撰寫，提升程式碼可讀性
- 使用Tailwind CSS樣式設計頁面
- 圖示使用Font Awesome，以方便控制大小顏色等設定
- 使用ES6使JavaScript語法變得簡潔（箭頭函式、key與value相同之簡寫等）
- 採用UJS寫法，維持HTML簡潔
- 運用AJAX技術，提升使用者體驗
- 使用Vue.js框架，透過製作軟體元件，減少維護及開發之負擔，提升程式碼再用性（reuse）
- 透過Vuex 狀態管理工具，避免掉元件分散時的狀態溝通問題，或元件集中管理時的全域變數污染問題
- 使用Turbolinks讓網頁切換更快速
- 使用Rails框架製作網頁
- 使用Action Cable，其底層為 web socket，實作了即時互動的功能
- 使用Rails內建之AJAX串接API
- 使用devise套件製作會員系統功能，並客製化
- 使用acts as list及Vue draggable套件，製作清單及卡片之拖曳功能
- 使用PostgreSQL資料庫儲存資料

## 功能
- 會員系統功能
  - 註冊、登入、登出
- 清單
  - 建立清單
  - 讀取清單
  - 修改清單名稱
  - 刪除清單
  - 拖拉移動清單
- 卡片
  - 建立卡片
  - 讀取卡片
  - 修改卡片名稱
  - 拖拉移動卡片（清單內之拖曳移動、跨清單之拖曳移動）
- 會員成功登入、登出...等，皆會於頁面上方跳出一次性系統訊息
- 即時互動功能，支援跨瀏覽器同步及時更新畫面

<!-- ## 畫面
### 瀏覽器畫面


### 行動裝置畫面 -->



## 安裝
以下皆為於macOS環境運行
### 安裝Ruby
```bash
$ brew install ruby
```
### 安裝Rails v6.1.4.6
```bash
$ gem install rails -v 6.1.4.6
```
### 下載PostgreSQL
```bash
$ brew install postgresql
```
### 建立資料庫
```bash
$ rails db:create
```
### 建立資料表
```bash
$ rails db:migrate
```
### 取得專案
```bash
$ git clone 
```
### 移動到專案內
```bash
$ cd 
```
### 安裝相關套件
```bash
$ bundle install
```

### 啟動rails伺服器
```bash
$ rails s
```
### 開啟專案
在瀏覽器網址列輸入以下網址即可看到專案首頁
```bash
http://localhost:3000/
```

## 主要資料夾及檔案說明
- app - 核心程式放置處
- bin - rails、webpack、yarn 基本指令放置處
- config- rails 的基本文件放置處
- db - 定義資料庫綱要（schema）、資料庫遷移（migration）之處
- lib - 自行定義檔案放置處（rake等）
- log - 本專案記錄檔放置處
- public - 本專案靜態檔案 (404、422、500 錯誤顯示畫面)
- spec - RSpec測試相關檔案放置處
- tmp - 臨時或暫時用文件放置處
- vender - 第三方文件放置處
- Gemfile - 要安裝 Ruby 的套件放置處
- Gemfile.lock - 當套件放置 /Gemfile 資料夾時，在終端機輸入 bundle install (可簡化為bundle)，會在此生成此套件的基本設定檔
- gitignore - 以 git 做版本控制時，不想被 git 追蹤的檔案名稱放置處
- Rakefile - 用來載入 rake 命令包含的任務

## 專案技術
- HTML
- CSS
  - SCSS
  - Font Awesome v6.5.2
  - Tailwind CSS v3.4.4
- JavaScripts
  - ES6
  - AJAX
  - Vue.js v3.4.30
  - Vuex
  - Vue draggable
- Ruby v2.7.8
  - Rails v6.1.4.6
    - acts as list v1.2.1
    - Action cable v6.1.7.8
    - devise v4.9.4
    - turbolinks v5.2.1
- PostgreSQL v1.5.6


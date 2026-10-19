# 站点维护指南

## 目录结构

```
├── content/            # 源文件（md）- 在此编辑内容
│   ├── _index.md       # 首页（导航 + 快速入口）
│   ├── data-dictionary/# 数据字典：数仓表结构
│   │   └── queries/    #   常用查询：高频数据查询 SQL
│   ├── projects/       # 项目管理（对应 OneDrive/Script）
│   │   ├── daily/      #   日常任务（每日/DailyMenu 触发）
│   │   ├── manage/     #   管理工具（按需运行）
│   │   └── monthly/    #   月度任务（每月运行）
│   ├── product/        # 产品记录：上新、变更历史
│   ├── glossary/       # 常用术语：指标与口径
│   └── reference/      # 参考资料：渠道分组等长效参考
├── assets/             # 自定义 SCSS
├── layouts/            # 自定义模板覆盖
├── static/             # 静态文件（favicon 等）
├── themes/hugo-book/   # Hugo Book 主题（已内嵌）
├── hugo.toml           # Hugo 配置
└── public/             # 构建产物（推送至 published 分支）
```

## 日常操作

### 添加新文章

在 `content/` 下新建 `.md` 文件，开头必须加 frontmatter：

```yaml
---
title: "文章标题"
weight: 1          # 排序，越小越靠前
---
```

_注意：文件名用中文，Hugo book 主题会按 weight 排序。_

### 预览

```powershell
hugo server --port 1314 --noHTTPCache --disableFastRender
```

浏览器访问 `http://localhost:1314/`

### 构建

```powershell
hugo --cleanDestinationDir
```

`public/` 目录即为线上文件。

### 部署

```powershell
# 1. 提交源码到 master（public/ 已被 .gitignore 忽略）
git add -A
git commit -m "更新内容."
git push origin master

# 2. 构建产物推送到 published 分支（EdgeOne 部署用）
hugo --cleanDestinationDir
$temp = "$env:TEMP\hugo-pub-$(Get-Random)"
Copy-Item -Recurse public "$temp"
Push-Location "$temp"
git init
git checkout -b published
git add -A
git commit -m "Deploy."
git remote add origin https://github.com/yoval/tll.jello.top.git
git push -f origin published
Pop-Location
Remove-Item -Recurse -Force $temp
```

> 直连 GitHub 失败时，在 git 命令前加代理参数：`git -c http.proxy=http://127.0.0.1:7890 <原始命令>`（Clash 默认端口 7890）。

## Hugo 扩展版路径

```
C:\Users\Administrator\AppData\Local\Microsoft\WinGet\Packages\Hugo.Hugo.Extended_Microsoft.Winget.Source_8wekyb3d8bbwe\hugo.exe
```

## EdgeOne Pages

- 站点域名：`tll.jello.top`（在 EdgeOne 控制台绑定自定义域名，并按提示配置 DNS 解析）
- 代码仓库：`https://github.com/yoval/tll.jello.top.git`
- 部署分支：`published`
- 构建命令：空
- 输出目录：`/`

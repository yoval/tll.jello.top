# 部署脚本：构建 Hugo 产物并推送到 published 分支
# 用法：.\deploy.ps1
# 注意：published 分支存放的是 hugo 编译后的静态文件（public/ 目录内容），不是源码。

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

Write-Host "==> 1/3 提交源码到 master..." -ForegroundColor Cyan
git add -A
$hasChanges = git diff --cached --quiet
if ($LASTEXITCODE -ne 0) {
    $msg = Read-Host "请输入 commit message（留空默认 'Update site.'）"
    if ([string]::IsNullOrWhiteSpace($msg)) { $msg = "Update site." }
    git commit -m $msg
    git push origin master
} else {
    Write-Host "    无未提交变更，跳过。" -ForegroundColor DarkGray
}

Write-Host "==> 2/3 构建 Hugo 静态文件..." -ForegroundColor Cyan
hugo --cleanDestinationDir
if ($LASTEXITCODE -ne 0) { throw "Hugo 构建失败" }

Write-Host "==> 3/3 推送静态文件到 published 分支..." -ForegroundColor Cyan
$temp = Join-Path $env:TEMP ("hugo-pub-" + (Get-Random))
Copy-Item -Recurse "public" $temp
Push-Location $temp
git init | Out-Null
git checkout -b published | Out-Null
git add -A | Out-Null
git commit -m ("Deploy: " + (git -C $PSScriptRoot rev-parse --short master)) | Out-Null
git remote add origin https://github.com/yoval/tll.jello.top.git
git push -f origin published
Pop-Location
Remove-Item -Recurse -Force $temp

Write-Host "==> 完成。EdgeOne Pages 将自动部署。" -ForegroundColor Green
Write-Host "    站点：https://tll.jello.top/"

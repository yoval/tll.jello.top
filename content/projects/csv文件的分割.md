---
title: "CSV文件分割"
weight: 51
---

# CSV文件分割

将过大的 CSV 按行数均分为多个带表头的小文件，解决部分系统无法上传 / 识别大文件的问题。

- **运行方式**：PowerShell 脚本，修改参数后直接执行

## 处理代码

```powershell
param(
    [string]$CsvPath = "5月产品数据.csv",
    [int]$Parts = 5,
    [string]$OutputDir = $PSScriptRoot
)

$reader = [System.IO.StreamReader]::new((Join-Path $OutputDir $CsvPath))
$header = $reader.ReadLine()

# 统计总行数
$totalLines = 0
while ($reader.ReadLine() -ne $null) {
    $totalLines++
}
$reader.Close()

$linesPerPart = [math]::Ceiling($totalLines / $Parts)
Write-Host "总数据行: $totalLines, 每份: $linesPerPart 行"

# 重新读取，开始分割
$reader = [System.IO.StreamReader]::new((Join-Path $OutputDir $CsvPath))
$reader.ReadLine() | Out-Null  # 跳过表头

$baseName = [System.IO.Path]::GetFileNameWithoutExtension($CsvPath)

for ($i = 0; $i -lt $Parts; $i++) {
    $partNum = $i + 1
    $outFile = Join-Path $OutputDir "${baseName}_part${partNum}.csv"

    $writer = [System.IO.StreamWriter]::new($outFile, $false, [System.Text.Encoding]::UTF8)
    $writer.WriteLine($header)

    $lineCount = 0
    while ($lineCount -lt $linesPerPart -and ($line = $reader.ReadLine()) -ne $null) {
        $writer.WriteLine($line)
        $lineCount++
    }

    $writer.Close()
    Write-Host "已生成: ${baseName}_part${partNum}.csv ($lineCount 行数据)"
}

$reader.Close()
Write-Host "分割完成!"
```

## 参数说明

| 参数 | 默认值 | 说明 |
|---|---|---|
| `$CsvPath` | `5月产品数据.csv` | 待分割文件名（与脚本同目录） |
| `$Parts` | `5` | 分割份数 |
| `$OutputDir` | 脚本所在目录 | 输出目录 |

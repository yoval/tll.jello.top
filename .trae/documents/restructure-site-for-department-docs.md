# 网站结构重组计划：适配部门文档定位

## Context

当前站点以 Hugo + hugo-book 构建，但存在以下问题：

1. **章节命名混乱**：`base-data`、`data-dictionary`、`script`、`new-product`、`win-sub-for-linux` 中英混杂，与部门中文文档定位不符
2. **`script/` 职责不清**：11 篇文章混杂了周期性备份、一次性取数需求、通用工具脚本三类内容，读者查找效率低
3. **首页信息过载**：数据源链接 + 渠道分组表格堆在同一页，首屏过长
4. **章节排序不合理**：`win-sub-for-linux`（开发环境）权重高于 `script`，不符合部门成员"先找数据、再找工具"的习惯

目标：重组为 8 个一级章节，命名统一为中文，按使用频率排序，首页聚焦导航与快速入口。

## Recommended Approach

### 新信息架构

| weight | 目录（slug） | 中文标题 | 来源 |
|---|---|---|---|
| 10 | `data-sources/` | 数据源 | 原 `base-data/` 平移 |
| 20 | `data-dictionary/` | 数据字典 | 保留，仅改 `_index.md` 标题 |
| 30 | `data-backup/` | 数据备份 | 从 `script/` 拆出 4 篇 |
| 40 | `data-needs/` | 数据需求 | 从 `script/` 拆出 4 篇 |
| 50 | `tools/` | 工具脚本 | 从 `script/` 拆出 3 篇 |
| 60 | `product/` | 产品记录 | 原 `new-product/` 平移 |
| 70 | `dev-env/` | 开发环境 | 原 `win-sub-for-linux/` 平移 |
| 80 | `reference/` | 参考资料 | 新建，吸收首页渠道分组 |

### 文件迁移映射

**`base-data/` → `data-sources/`**（5 篇平移）
- `content/base-data/_index.md` → `content/data-sources/_index.md`
- `content/base-data/门店信息.md` → `content/data-sources/门店信息.md`
- `content/base-data/门店销售数据.md` → `content/data-sources/门店销售数据.md`
- `content/base-data/产品销售数据.md` → `content/data-sources/产品销售数据.md`
- `content/base-data/门店报货数据.md` → `content/data-sources/门店报货数据.md`
- `content/base-data/标准菜品名称.md` → `content/data-sources/标准菜品名称.md`

**`script/` 一拆三**（11 篇）
- 备份类 4 篇 → `data-backup/`：门店销售数据的备份、产品销售数据备份、门店管理表日备份、北森通讯录信息日备份
- 需求类 4 篇 → `data-needs/`：月度产品销售数据、各渠道同比基础数据、赠茶数据需求、周边数据需求
- 工具类 3 篇 → `tools/`：标准菜品名称清洗、标准菜品名称核对、csv文件的分割

**`new-product/` → `product/`**（1 篇平移）
- `content/new-product/_index.md` → `content/product/_index.md`
- `content/new-product/2026产品上新记录.md` → `content/product/2026产品上新记录.md`

**`win-sub-for-linux/` → `dev-env/`**（1 篇平移）
- `content/win-sub-for-linux/_index.md` → `content/dev-env/_index.md`
- `content/win-sub-for-linux/WSL的安装.md` → `content/dev-env/WSL的安装.md`

**`data-dictionary/`** 保留目录，仅 `_index.md` 标题改为「数据字典」，weight 改为 20

**新建 `reference/`**
- `content/reference/_index.md`：title「参考资料」，weight 80
- `content/reference/渠道分组.md`：从 `content/_index.md` 抽出 mermaid + 表格

### 首页重写（`content/_index.md`）

保留 `title: Data Documentation` 与 `weight: 1`，正文重写为：

```markdown
# 数据与产品部门文档

> 本站点记录部门日常使用的数据源、数据字典、备份脚本、产品记录与开发环境配置。

## 快速入口

- [门店销售数据](/data-sources/门店销售数据)
- [门店管理表日备份](/data-backup/门店管理表日备份)
- [渠道分组对照](/reference/渠道分组)
- [2026 产品上新记录](/product/2026产品上新记录)

## 内容导航

- **数据源**：各业务系统的数据口径说明
- **数据字典**：数仓表结构与字段含义
- **数据备份**：周期性同步到本地的数据
- **数据需求**：历史一次性取数需求存档
- **工具脚本**：通用 Python / 数据处理脚本
- **产品记录**：产品上新、变更历史
- **开发环境**：部门统一的开发环境搭建指南
- **参考资料**：渠道分组、术语对照等长效参考

## 维护说明

内容位于 `content/`，文件名为中文，使用 Hugo Book 主题。提交与部署流程见仓库根目录 `SITE-GUIDE.md`。
```

### 统一 frontmatter 规范

所有新 section 的 `_index.md` 保留 `bookFlatSection: true`，使用阶梯 weight（10/20/30...）：

```yaml
---
title: 数据源
weight: 10
bookFlatSection: true
---
```

普通文档的 frontmatter 保持现有规范：`title: "中文标题"` + `weight: 1/2/3...`。

### 需要修正的交叉引用

1. `content/data-sources/门店销售数据.md`：首页渠道分组链接 → `{{< ref "/reference/渠道分组" >}}`
2. `content/data-sources/标准菜品名称.md`：`/script/标准菜品名称核对` → `/tools/标准菜品名称核对`
3. `content/data-sources/门店信息.md`：`/script/门店管理表日备份` → `/data-backup/门店管理表日备份`
4. `content/data-needs/各渠道同比基础数据.md`：`relref "门店销售数据的备份"` → `ref "/data-backup/门店销售数据的备份"`

### hugo.toml 调整

仅保留现有配置，站点标题 `Data Documentation` 保持不变（用户明确要求）。

## Verification

1. 本地启动 `hugo server --port 1314 --noHTTPCache --disableFastRender`
2. 检查侧边栏 8 个章节是否按预期顺序显示
3. 逐一点击各章节页面，确认无 404、无断链
4. 检查搜索功能是否正常
5. `hugo --cleanDestinationDir` 构建成功，页面数与预期一致
6. 按 `SITE-GUIDE.md` 流程部署到 `published` 分支

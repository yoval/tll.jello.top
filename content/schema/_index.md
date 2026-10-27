---
title: 数据字典
weight: 20
bookCollapseSection: true
---

数据表结构与业务口径说明。数仓表按层级组织，业务库配置表归入 `biz/`。

## 数据库环境

| 项 | 值 |
|---|---|
| 类型 | 腾讯云 CDW Doris（兼容 MySQL 5.7 协议） |
| 版本 | MySQL 5.7.99 / Doris 2.1.12 |
| 字符集 | utf8mb4 / utf8mb4_0900_bin |

### 库清单

| 库 | 说明 |
|---|---|
| `tll_bi_dw` | 数仓库，ADS/DWD/DIM 全部在此 |
| `cloud_cube_trade` | 中台交易配置库，目前仅用到 `channel_mapping`（渠道映射） |

跨库查询示例：`tll_bi_dw.ads_dbs_trade_shop_pay_channel_di` JOIN `cloud_cube_trade.channel_mapping`

## 目录结构

| 目录 | 层级 | 库 | 命名规范 |
|---|---|---|---|
| **ADS** | 业务汇总层 | `tll_bi_dw` | `ads_dbs_trade_*` |
| **DWD** | 明细层 | `tll_bi_dw` | `dwd_*_di` / `dwd_*_df` |
| **DIM** | 维度层 | `tll_bi_dw` | `dim_*_df` |
| **BIZ** | 业务库配置 | 中台业务库 | 业务库原生表 |

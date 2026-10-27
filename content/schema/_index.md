---
title: 数据字典
weight: 20
bookCollapseSection: true
---

数据表结构与业务口径说明。数仓表按层级组织，业务库配置表归入 `biz/`。

| 目录 | 层级 | 库 | 命名规范 |
|---|---|---|---|
| **ADS** | 业务汇总层 | `tll_bi_dw` | `ads_dbs_trade_*` |
| **DWD** | 明细层 | `tll_bi_dw` | `dwd_*_di` / `dwd_*_df` |
| **DIM** | 维度层 | `tll_bi_dw` | `dim_*_df` |
| **BIZ** | 业务库配置 | `cloud_cube_trade` 等 | 业务库原生表 |

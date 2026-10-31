---
title: 常用查询
weight: 25
bookCollapseSection: true
---

日常直接用的 SQL 片段，固定过滤条件已写成占位符，复制改日期即可跑。

## 门店销售

| 查询 | 数据源 | 说明 |
|---|---|---|
| [门店日GMV查询]({{< ref "/queries/trade/门店日GMV查询" >}}) | shop_pay_channel_di | 按门店 × 日期查流水总额 |
| [加盟店每日各渠道流水]({{< ref "/queries/trade/加盟店每日各渠道流水" >}}) | shop_pay_channel_di | 按门店 × 渠道 × 日期拆分 |
| [来源渠道月流水与营业天数]({{< ref "/queries/trade/来源渠道月流水与营业天数" >}}) | shop_di | 门店×月×渠道的流水/实收/订单数+营业天数 |

## 产品销售

| 查询 | 数据源 | 说明 |
|---|---|---|
| [赠茶数据查询]({{< ref "/queries/product/赠茶数据查询" >}}) | food_di | 指定时段/城市，实收为 0 的茶品销量明细 |

## 门店报货

| 查询 | 数据源 | 说明 |
|---|---|---|
| [门店报货金额]({{< ref "/queries/order/门店报货金额" >}}) | dwd_rps_tll_order_data_merge_di | 指定月份各门店报货金额 |

## 门店管理

| 查询 | 数据源 | 说明 |
|---|---|---|
| [全量门店查询]({{< ref "/queries/shop/全量门店查询" >}}) | shop_info | 每个门店编号的最新记录行（含已解约门店） |
| [中台门店全量查询]({{< ref "/queries/shop/中台门店全量查询" >}}) | dim_oas_formmain_0145_df | 中台门店管理表最新分区全量快照（Doris） |
| [月末运营状态]({{< ref "/queries/shop/月末运营状态" >}}) | shop_info | 指定月份末 省 × 市 × 门店类型 × 运营状态 门店数 |

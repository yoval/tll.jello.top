---
title: 常用查询
weight: 25
bookCollapseSection: true
---

日常直接用的 SQL 片段，固定过滤条件已写成占位符，复制改日期即可跑。

| 查询 | 数据源 | 说明 |
|---|---|---|
| [门店日GMV查询]({{< ref "/queries/门店日GMV查询" >}}) | shop_pay_channel_di | 按门店 × 日期查流水总额 |
| [加盟店每日各渠道流水]({{< ref "/queries/加盟店每日各渠道流水" >}}) | shop_pay_channel_di | 按门店 × 渠道 × 日期拆分 |
| [赠茶数据查询]({{< ref "/queries/赠茶数据查询" >}}) | shop_pay_channel_di | 查赠送/减免类订单 |
| [来源渠道月流水与营业天数]({{< ref "/queries/来源渠道月流水与营业天数" >}}) | shop_di | 门店×月×渠道的流水/实收/订单数+营业天数 |
| [全量门店查询]({{< ref "/queries/全量门店查询" >}}) | shop_info | 每个门店编号的最新记录行（含已解约门店） |
| [中台门店全量查询]({{< ref "/queries/中台门店全量查询" >}}) | dim_oas_formmain_0145_df | 中台门店管理表最新分区全量快照（Doris） |

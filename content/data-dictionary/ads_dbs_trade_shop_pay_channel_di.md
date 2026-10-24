---
title: "门店销售（支付渠道）"
weight: 1
---

# 门店销售

门店渠道销售日表，粒度为 门店 × 日期 × 支付原始渠道，表名 `ads_dbs_trade_shop_pay_channel_di`（库 `tll_bi_dw`）。

{{< notice info "推荐使用此表" >}}
门店销售流水的**首选来源**。

**唯一原因：中台驾驶舱 → 渠道拆分模块以此表为基准**。如果不用这张，输出数据会和中台对不上。

虽然 [ads_dbs_trade_shop_di]({{< ref "/data-dictionary/ads_dbs_trade_shop_di" >}})（来源渠道）在业务上是更好的选择——能直接对应到 `ads_dbs_trade_food_di`（商品流水）口径，可拆分配送费/包装费。但为了数据一致性，门店销售统一采用本表。
{{< /notice >}}

## 字段查询

```sql
SELECT 
    COLUMN_NAME AS 字段名, 
    COLUMN_TYPE AS 字段类型, 
    COLUMN_COMMENT AS 字段注释 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'tll_bi_dw' 
AND TABLE_NAME = 'ads_dbs_trade_shop_pay_channel_di';
```

## 字段说明

| 列名              | 数据类型         | 注释           |
| ----------------- | ---------------- | -------------- |
| pt                | varchar(20)      | 时间分区       |
| shop_id           | varchar(20)      | 门店编号       |
| payment_channels  | varchar(100)     | 结账方式名称   |
| order_cnt         | bigint(20)       | 订单量         |
| income            | decimalv3(16, 2) | 收入金额       |
| discount          | decimalv3(16, 2) | 优惠金额       |
| amount            | decimalv3(16, 2) | 流水金额       |
| total_order_cnt   | bigint(20)       | 订单量         |
| item_scrap_amount | decimalv3(16, 2) | 报废金额       |

## payment_channels 枚举值

```sql
SELECT DISTINCT payment_channels
FROM ads_dbs_trade_shop_pay_channel_di;
```

| 渠道 | 类别（参考分组） |
|---|---|
| pos收银 | POS |
| 甜啦啦小程序 | 小程序 |
| 甜啦啦小程序-储值业务 | 小程序 |
| 微信小程序 | 小程序 |
| 支付宝小程序 | 小程序 |
| 抖音小程序（核销工具） | 小程序 |
| 美团/大众点评小程序 | 小程序 |
| 美团外卖 | 外卖 |
| 淘宝闪购 | 外卖 |
| 京东外卖 | 外卖 |
| 抖音团购 | 团购 |
| 线上新增抖音团购 | 团购 |
| 快手团购 | 团购 |
| 线上新增快手团购 | 团购 |
| 高德团购 | 团购 |
| 美团/大众点评团购 | 团购 |
| 线上新增美团团购 | 团购 |
| 美团在线点 | 团购 |

> `payment_channels` 是最细粒度的**原始支付渠道**，与 shop_di / food_di 两张表的 `channel_name` 并非一一对应。
> 分组映射（pos / 小程序 / 外卖 / 团购）见 [支付渠道分组]({{< ref "/reference/渠道分组" >}})。

## 注意事项

{{< notice warning "注意" >}}
检查当月渠道是否完整，是否有缺失的渠道（核对当月是否有 `线上新增xx团购`）。渠道口径见 [支付渠道分组]({{< ref "/reference/渠道分组" >}})。
{{< /notice >}}

## 渠道完整性检查

```sql
SELECT DISTINCT
	payment_channels 
FROM
	ads_dbs_trade_shop_pay_channel_di 
WHERE
	pt LIKE '202605%'
```

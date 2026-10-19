---
title: "门店销售"
weight: 1
---

# 门店销售

门店渠道销售日表，粒度为 门店 × 日期 × 支付原始渠道，表名 `ads_dbs_trade_shop_pay_channel_di`（库 `tll_bi_dw`）。

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

## 注意事项

{{< notice warning "注意" >}}
检查当月渠道是否完整，是否有缺失的渠道（核对当月是否有 `线上新增xx团购`）。渠道口径见 [渠道分组]({{< ref "/reference/渠道分组" >}})。
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

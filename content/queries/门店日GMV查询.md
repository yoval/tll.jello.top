---
title: "门店日GMV查询"
weight: 1
---

# 门店日GMV查询

按日期范围统计全部门店每日 GMV（流水合计），数据来自门店渠道销售表。

- **数据表**：[ads_dbs_trade_shop_pay_channel_di]({{< ref "/schema/ads/ads_dbs_trade_shop_pay_channel_di" >}})
- **粒度**：日期 × 全部门店（`shop_id LIKE 'TLL%'`，仅加盟门店）
- **指标**：`SUM(amount)` 流水金额

## SQL

```sql
SELECT
    pt AS 日期,
    SUM(amount) AS 总流水
FROM ads_dbs_trade_shop_pay_channel_di
WHERE pt >= 20261001 AND pt <= 20261016
    AND shop_id LIKE 'TLL%'
GROUP BY pt
ORDER BY pt;
```

## 参数调整

- **单日**：起止日期改为同一天，如 `pt >= 20261016 AND pt <= 20261016`
- **单店**：增加门店编号过滤 `AND shop_id = 'TLL00001'`
- **含直营店**：放宽门店过滤为 `AND (shop_id LIKE 'TLL%' OR shop_id LIKE 'ZYD%')`

## 注意事项

{{< notice warning "注意" >}}
`pt` 为整数类型，条件值不要加引号；中台会刷新前一个月的数据，跨月查询时当月与上月数字可能轻微变动。
{{< /notice >}}

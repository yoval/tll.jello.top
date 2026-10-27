---
title: "门店销售（来源渠道）"
weight: 2
---

# 门店销售

门店日汇总表，粒度为 门店 × 日期 × 渠道，表名 `ads_dbs_trade_shop_di`（库 `tll_bi_dw`）。

## 字段查询

```sql
SELECT 
    COLUMN_NAME AS 字段名, 
    COLUMN_TYPE AS 字段类型, 
    COLUMN_COMMENT AS 字段注释 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'tll_bi_dw' 
AND TABLE_NAME = 'ads_dbs_trade_shop_di';
```

## 字段说明

| 字段名 | 字段类型 | 字段注释 |
|---|---|---|
| business_date | varchar(20) | 日期 |
| prov_id | varchar(100) | 省份编码 |
| prov_name | varchar(100) | 省份名称 |
| city_id | varchar(100) | 城市编码 |
| city_name | varchar(100) | 城市名称 |
| city_level | varchar(100) | 城市等级 |
| district_id | varchar(100) | 区县编码 |
| district_name | varchar(100) | 区县名称 |
| bussiness_type | varchar(100) | 业务类型 |
| anal_type | varchar(100) | 分析类型 |
| shop_id | varchar(20) | 门店统计 id |
| channel_name | varchar(100) | 渠道 |
| franchisee_type | varchar(20) | 门店类型 |
| food_sales_amount | decimalv3(16, 2) | 菜品销售 |
| total_mealFee | decimalv3(16, 2) | 总餐盒费 |
| freight_amount | decimalv3(16, 2) | 配送费（商家配送） |
| total_amount | decimalv3(16, 2) | 流水金额 |
| pay_amount | decimalv3(16, 2) | 实收金额 |
| order_count | bigint(20) | 订单量 |
| discount_amount | decimalv3(16, 2) | 优惠金额 |
| item_scrap_amount | decimalv3(16, 2) | 报废金额 |
| dp_item_count | bigint(20) | 商品销量 |
| dp_total_amount | decimalv3(16, 2) | 商品流水金额 |
| pt | varchar(20) | 时间分区 |

## shop_di vs food_di channel_name 差异

`ads_dbs_trade_shop_di`（门店销售）和 `ads_dbs_trade_food_di`（产品销售）的渠道名存在两处不同：

| 差异 | shop_di | food_di |
|---|---|---|
| 到店-小程序 | `小程序`（一条汇总） | `微信小程序` + `支付宝小程序`（两条分开） |
| 渠道总数 | 12 条 | 14 条 |

> 两张表的 `anal_type` 取值一致（`到家` / `到店`），到家 4 个渠道完全相同。

## anal_type × channel_name 枚举值

```sql
SELECT DISTINCT anal_type, channel_name
FROM ads_dbs_trade_shop_di;
```

| anal_type | channel_name |
|---|---|
| 到家 | 美团外卖 |
| 到家 | 淘宝闪购 |
| 到家 | 自营外卖 |
| 到家 | 京东外卖 |
| 到店 | pos 收银 |
| 到店 | 小程序（微信 / 支付宝） |
| 到店 | 抖音小程序（核销工具） |
| 到店 | 美团/大众点评团购 |
| 到店 | 抖音团购 |
| 到店 | 高德团购 |
| 到店 | 快手团购 |
| 到店 | 美团在线点 |

## 注意事项

{{< notice warning "注意" >}}
1. 门店销售汇总 ≥ 产品销售汇总，差额来自配送费、包装费（算门店流水但不算商品流水）。
2. channel_name 为来源渠道，非原始支付渠道。
3. **门店销售流水建议优先使用 [支付渠道版]({{< ref "/data-dictionary/ads/ads_dbs_trade_shop_pay_channel_di" >}})**，中台驾驶舱以此为基准。
4. 两表渠道口径差异及对比见 [来源渠道对比]({{< ref "/reference/来源渠道对比" >}})。
{{< /notice >}}

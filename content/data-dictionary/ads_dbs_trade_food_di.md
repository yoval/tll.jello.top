---
title: "产品销售（来源渠道）"
weight: 3
---

# 产品销售

产品（商品）销售日表，粒度为 门店 × 日期 × 渠道 × 商品，表名 `ads_dbs_trade_food_di`（库 `tll_bi_dw`）。

## 字段查询

```sql
SELECT 
    COLUMN_NAME AS 字段名, 
    COLUMN_TYPE AS 字段类型, 
    COLUMN_COMMENT AS 字段注释 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'tll_bi_dw' 
AND TABLE_NAME = 'ads_dbs_trade_food_di';
```

## 字段说明

| 字段名                           | 字段类型         | 字段注释                                               |
| -------------------------------- | ---------------- | ------------------------------------------------------ |
| business_date                    | bigint(20)       | 日期                                                   |
| oper_center_name                 | varchar(255)     | 营运中心                                               |
| prov_id                          | varchar(64)      | 省份编码                                               |
| prov_name                        | varchar(255)     | 省份名称                                               |
| city_id                          | varchar(64)      | 城市编码                                               |
| city_name                        | varchar(255)     | 城市名称                                               |
| city_level                       | varchar(64)      | 城市等级                                               |
| district_id                      | varchar(64)      | 区县编码                                               |
| district_name                    | varchar(255)     | 区县名称                                               |
| busi_area_type                   | varchar(64)      | 商圈                                                   |
| bussiness_type                   | varchar(64)      | 业务类型                                               |
| channel_name                     | varchar(255)     | 订单渠道                                               |
| anal_type                        | varchar(64)      | 分析类型(到家、到店)                                   |
| platform                         | varchar(64)      | 平台(到家：美团、饿了么、其它 到店：POS、小程序、其它) |
| cust_type                        | varchar(64)      | 用户类型                                               |
| time_name                        | varchar(255)     | 时段                                                   |
| food_category_name               | varchar(255)     | 商品分类                                               |
| food_oneid                       | varchar(128)     |                                                        |
| item_name                        | varchar(500)     | 商品名称                                               |
| new_flag                         | varchar(64)      | 是否新品                                               |
| cup_type                         | varchar(64)      | 杯型                                                   |
| ice_type                         | varchar(64)      | 温度                                                   |
| sugar_type                       | varchar(64)      | 甜度                                                   |
| dp_total_amount                  | decimalv3(16, 2) | 商品流水金额                                           |
| dp_total_amount_last_day         | decimalv3(16, 2) | 上一天商品流水金额                                     |
| dp_total_amount_last_week        | decimalv3(16, 2) | 上一周商品流水金额                                     |
| dp_total_amount_last_year        | decimalv3(16, 2) | 去年同期商品流水金额                                   |
| dp_item_count                    | bigint(20)       | 商品销量                                               |
| dp_item_count_last_day           | bigint(20)       | 上一天商品销量                                         |
| dp_item_count_last_week          | bigint(20)       | 上一周商品销量                                         |
| dp_item_count_last_year          | bigint(20)       | 去年同期商品销量                                       |
| dp_pay_amount                    | decimalv3(16, 2) | 商品实收金额                                           |
| dp_pay_amount_last_day           | decimalv3(16, 2) | 上一天商品实收金额                                     |
| dp_pay_amount_last_week          | decimalv3(16, 2) | 上一周商品实收金额                                     |
| dp_pay_amount_last_year          | decimalv3(16, 2) | 去年同期商品实收金额                                   |
| dp_discount_amount               | decimalv3(16, 2) | 商品优惠金额                                           |
| dp_discount_amount_last_day      | decimalv3(16, 2) | 上一天商品优惠金额                                     |
| dp_discount_amount_last_week     | decimalv3(16, 2) | 上一周商品优惠金额                                     |
| dp_discount_amount_last_year     | decimalv3(16, 2) | 去年同期商品优惠金额                                   |
| dp_return_item_count             | bigint(20)       | 商品退货量                                             |
| dp_return_item_count_last_day    | bigint(20)       | 上一天商品退货量                                       |
| dp_return_item_count_last_week   | bigint(20)       | 上一周商品退货量                                       |
| dp_return_item_count_last_year   | bigint(20)       | 去年同期商品退货量                                     |
| dp_return_total_amount           | decimalv3(16, 2) | 商品退款金额                                           |
| dp_return_total_amount_last_day  | decimalv3(16, 2) | 上一天商品退款金额                                     |
| dp_return_total_amount_last_week | decimalv3(16, 2) | 上一周商品退款金额                                     |
| dp_return_total_amount_last_year | decimalv3(16, 2) | 去年同期商品退款金额                                   |
| xl_total_amount                  | decimalv3(16, 2) | 小料流水金额                                           |
| xl_total_amount_last_day         | decimalv3(16, 2) | 上一天小料流水金额                                     |
| xl_total_amount_last_week        | decimalv3(16, 2) | 上一周小料流水金额                                     |
| xl_total_amount_last_year        | decimalv3(16, 2) | 去年同期小料流水金额                                   |
| xl_item_count                    | bigint(20)       | 小料销量                                               |
| xl_item_count_last_day           | bigint(20)       | 上一天小料销量                                         |
| xl_item_count_last_week          | bigint(20)       | 上一周小料销量                                         |
| xl_item_count_last_year          | bigint(20)       | 去年同期小料销量                                       |
| xl_pay_amount                    | decimalv3(16, 2) | 小料实收金额                                           |
| xl_pay_amount_last_day           | decimalv3(16, 2) | 上一天小料实收金额                                     |
| xl_pay_amount_last_week          | decimalv3(16, 2) | 上一周小料实收金额                                     |
| xl_pay_amount_last_year          | decimalv3(16, 2) | 去年同期小料实收金额                                   |
| tc_total_amount                  | decimalv3(16, 2) | 套餐流水金额                                           |
| tc_total_amount_last_day         | decimalv3(16, 2) | 上一天套餐流水金额                                     |
| tc_total_amount_last_week        | decimalv3(16, 2) | 上一周套餐流水金额                                     |
| tc_total_amount_last_year        | decimalv3(16, 2) | 去年同期套餐流水金额                                   |
| tc_item_count                    | bigint(20)       | 套餐销量                                               |
| tc_item_count_last_day           | bigint(20)       | 上一天套餐销量                                         |
| tc_item_count_last_week          | bigint(20)       | 上一周套餐销量                                         |
| tc_item_count_last_year          | bigint(20)       | 去年同期套餐销量                                       |
| tc_pay_amount                    | decimalv3(16, 2) | 套餐实收金额                                           |
| tc_pay_amount_last_day           | decimalv3(16, 2) | 上一天套餐实收金额                                     |
| tc_pay_amount_last_week          | decimalv3(16, 2) | 上一周套餐实收金额                                     |
| tc_pay_amount_last_year          | decimalv3(16, 2) | 去年同期套餐实收金额                                   |
| tc_discount_amount               | decimalv3(16, 2) | 套餐优惠金额                                           |
| tc_discount_amount_last_day      | decimalv3(16, 2) | 上一天套餐优惠金额                                     |
| tc_discount_amount_last_week     | decimalv3(16, 2) | 上一周套餐优惠金额                                     |
| tc_discount_amount_last_year     | decimalv3(16, 2) | 去年同期套餐优惠金额                                   |
| zb_total_amount                  | decimalv3(16, 2) | 周边流水金额                                           |
| zb_total_amount_last_day         | decimalv3(16, 2) | 上一天周边流水金额                                     |
| zb_total_amount_last_week        | decimalv3(16, 2) | 上一周周边流水金额                                     |
| zb_total_amount_last_year        | decimalv3(16, 2) | 去年同期周边流水金额                                   |
| zb_item_count                    | bigint(20)       | 周边销量                                               |
| zb_item_count_last_day           | bigint(20)       | 上一天周边销量                                         |
| zb_item_count_last_week          | bigint(20)       | 上一周周边销量                                         |
| zb_item_count_last_year          | bigint(20)       | 去年同期周边销量                                       |
| zb_pay_amount                    | decimalv3(16, 2) | 周边实收金额                                           |
| zb_pay_amount_last_day           | decimalv3(16, 2) | 上一天周边实收金额                                     |
| zb_pay_amount_last_week          | decimalv3(16, 2) | 上一周周边实收金额                                     |
| zb_pay_amount_last_year          | decimalv3(16, 2) | 去年同期周边实收金额                                   |
| load_time                        | varchar(64)      | 数据更新时间                                           |
| item_type                        | varchar(64)      | 商品类型（单品、套餐、小料、周边、其它）               |
| item_status                      | varchar(64)      | 饮品状态(在线饮品、不在线饮品)                         |
| up_type                          | varchar(64)      | 升级类型                                               |
| food_series                      | varchar(64)      | 商品系列                                               |
| release_date                     | varchar(64)      | 上新日期                                               |
| dp_order_count                   | bigint(20)       | 商品订单量                                             |
| xl_order_count                   | bigint(20)       | 小料订单量                                             |
| item_name_list                   | varchar(255)     | 套餐下商品/小料明细                                    |
| other_total_amount               | decimalv3(16, 2) | 其它饮品流水金额                                       |
| other_total_amount_last_day      | decimalv3(16, 2) | 昨日其它饮品流水金额                                   |
| other_total_amount_last_week     | decimalv3(16, 2) | 上周同期其它饮品流水金额                               |
| other_total_amount_last_year     | decimalv3(16, 2) | 去年同期其它饮品流水金额                               |
| stat_shop_id                     | varchar(64)      | 门店统计id                                             |
| stat_shop_name                   | varchar(255)     | 门店统计名称                                           |
| send_whse                        | varchar(64)      | 仓库                                                   |

## food_di vs shop_di channel_name 差异

`ads_dbs_trade_food_di`（产品销售）和 `ads_dbs_trade_shop_di`（门店销售）的渠道名存在两处不同：

| 差异 | food_di | shop_di |
|---|---|---|
| 到店-小程序 | `微信小程序` + `支付宝小程序`（两条分开） | `小程序`（一条汇总） |
| 渠道总数 | 14 条 | 12 条 |

> 两张表的 `anal_type` 取值一致（`到家` / `到店`），到家 4 个渠道完全相同。

## anal_type × channel_name 枚举值

```sql
SELECT DISTINCT anal_type, channel_name
FROM ads_dbs_trade_food_di;
```

| anal_type | channel_name |
|---|---|
| 到家 | 美团外卖 |
| 到家 | 淘宝闪购 |
| 到家 | 自营外卖 |
| 到家 | 京东外卖 |
| 到店 | pos 收银 |
| 到店 | 微信小程序 |
| 到店 | 支付宝小程序 |
| 到店 | 抖音小程序（核销工具） |
| 到店 | 美团/大众点评团购 |
| 到店 | 抖音团购 |
| 到店 | 高德团购 |
| 到店 | 快手团购 |
| 到店 | 美团在线点 |

## 注意事项

{{< notice warning "注意" >}}
1. 产品销售汇总 < 门店销售汇总。
2. 门店销售包含快递等非商品营业额，以及补录营业额。
{{< /notice >}}

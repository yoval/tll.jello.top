---
title: "门店报货信息"
weight: 1
---

# 门店报货信息

门店报货订单明细日表，粒度为订单 × 商品明细，表名 `dwd_rps_tll_order_details_di`（库 `tll_bi_dw`）。

## 字段查询

```sql
SELECT 
    COLUMN_NAME AS 字段名, 
    COLUMN_TYPE AS 字段类型, 
    COLUMN_COMMENT AS 字段注释 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'tll_bi_dw' 
AND TABLE_NAME = 'dwd_rps_tll_order_details_di';
```

## 字段说明

| 列名                            | 数据类型         | 注释                                                   |
| ------------------------------- | ---------------- | ------------------------------------------------------ |
| pt                              | varchar(255)     | 天分区                                                 |
| id                              | varchar(255)     | 明细ID                                                 |
| order_id                        | varchar(255)     | 订单号                                                 |
| product_info                    | varchar(255)     | 商品信息                                               |
| product_specification           | varchar(255)     | 商品规格                                               |
| product_id                      | varchar(255)     | 商品ID                                                 |
| sku_code                        | varchar(255)     | SKU代码                                                |
| supplier                        | varchar(255)     | 供应商                                                 |
| unit_price                      | decimalv3(10, 2) | 单价                                                   |
| quantity                        | int(11)          | 购买数量                                               |
| cancel_quantity                 | int(11)          | 取消数量                                               |
| payable_amount                  | decimalv3(10, 2) | 应付金额                                               |
| discount_amount                 | decimalv3(10, 2) | 优惠金额                                               |
| actual_amount                   | decimalv3(10, 2) | 实付金额                                               |
| status                          | int(11)          | 状态                                                   |
| tenant_id                       | varchar(255)     | 租户ID                                                 |
| create_time                     | varchar(255)     | 创建时间                                               |
| product_type                    | varchar(255)     | 商品类型                                               |
| warehouse_id                    | int(11)          | 发货仓库                                               |
| warehouse_batch_no              | varchar(255)     | 仓库批次号                                             |
| category_id                     | bigint(20)       | 类目id                                                 |
| tax_rate                        | decimalv3(10, 2) | 税率                                                   |
| is_freebies                     | int(11)          | 是否为赠品：0：否 1：是                                |
| packaging_unit                  | varchar(255)     | 包装单位                                               |
| unit_code                       | varchar(255)     | 单位编码                                               |
| serial_no                       | varchar(255)     | 流水号                                                 |
| out_quantity                    | int(11)          | 出库数量                                               |
| customer_discount_amount        | decimalv3(10, 2) | 客户优惠                                               |
| rent_subsidy_amount             | decimalv3(10, 2) | 房租优惠                                               |
| agent_amount                    | decimalv3(10, 2) | 代理商代收代付款                                       |
| bank_actual_amount              | decimalv3(10, 2) | 银行实付金额                                           |
| pt_discount_amount              | decimalv3(10, 2) | 平台优惠金额                                           |
| is_combination_children_product | int(11)          | 是否是组合子商品(1-是,2-否)                            |
| final_pay_amount                | decimalv3(10, 2) | 最终支付金额，包含银行和平台付款，折后单价乘以出库数量 |
| cancel_order_num                | string           | 退款单号                                               |
| created_at                      | string           | 退款时间                                               |
| warehouse_name                  | string           | 仓库名称                                               |
| refund_fee                      | decimalv3(10, 2) | 退单金额                                               |
| modify_time                     | varchar(255)     | 更新时间                                               |
| activity_id                     | varchar(255)     | 活动id                                                 |
| combination_code                | varchar(255)     | 组合商品编码                                           |
| logistic_fee_amount             | decimalv3(10, 2) |                                                        |
| has_logistic_fee                | int(11)          |                                                        |
| delivery_method                 | int(11)          | 配送方式,1:物流,2:快递,3:上门自提                      |
| shipping_method                 | int(11)          | 送货方式,0:起订,1:包邮,2:送货上门                      |
| real_store_code                 | varchar(128)     | 真实门店code                                           |

## 关联表

| 表 | 关系 |
|---|---|
| [dwd_rps_tll_order_di]({{< ref "/schema/dwd/dwd_rps_tll_order_di" >}}) | 订单头表，详表 `order_id` = 头表 `id` |

## 注意事项

{{< notice warning "注意" >}}
1. 与头表关联时用详表 `order_id` = 头表 `id`，不是 `order_num`。
2. 报货记录通常以财务部统计为准。
{{< /notice >}}

---
title: "门店报货订单头"
weight: 2
---

# 门店报货订单头

门店报货订单头日表，粒度为订单（一单一头），表名 `dwd_rps_tll_order_di`（库 `tll_bi_dw`）。

与 [门店报货信息（详表）]({{< ref "/schema/dwd/dwd_rps_tll_order_details_di" >}}) 配套：头表存订单级状态/金额/时间，详表存商品明细。通过 `id`（头表）= `order_id`（详表）关联。

## 字段查询

```sql
SELECT 
    COLUMN_NAME AS 字段名, 
    COLUMN_TYPE AS 字段类型, 
    COLUMN_COMMENT AS 字段注释 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'tll_bi_dw' 
AND TABLE_NAME = 'dwd_rps_tll_order_di';
```

## 字段说明

### 订单核心

| 字段 | 类型 | 注释 |
|---|---|---|
| pt | varchar(255) | 天分区 |
| id | varchar(255) | 订单号（主键，详表 `order_id` 的关联键） |
| order_num | varchar(255) | 订单编号（业务编号） |
| order_type | int(11) | 订单类型：1-普通 2-待客下单 |
| order_category | int(11) | 订单类别：1-B2B 2-B2C |
| order_product_type | int(11) | 订单商品类型：1-纯水果 2-纯速冻 3-混合型 |
| order_source | varchar(255) | 订单来源：如甜掌柜 |
| tenant_id | varchar(255) | 租户 ID |
| third_order_no | bigint(20) | 第三方单号 |

### 状态与时间

| 字段 | 类型 | 注释 |
|---|---|---|
| order_status | int(11) | 订单状态（见下方枚举） |
| order_notes | varchar(1024) | 订单备注 |
| has_cancel | int(11) | 是否取消过：0/1 |
| cancel_type | varchar(255) | 取消类型 |
| cancel_reason | varchar(1024) | 取消理由 |
| need_destruction | int(11) | 是否销毁物品：0 否 / 1 是 |
| has_apply_after_sale | int(11) | 是否申请过售后：0 否 / 1 是 |
| order_time | varchar(255) | 下单时间 |
| pay_time | varchar(255) | 支付时间 |
| cancel_time | varchar(255) | 取消时间 |
| review_time | varchar(255) | 审核时间 |
| delivery_time | varchar(255) | 发货时间 |
| user_confirm_time | varchar(255) | 用户确认收货时间 |
| expected_time | varchar(255) | 期望送达时间 |
| created_time | varchar(255) | 创建时间 |
| created_by | varchar(255) | 创建人 |
| updated_time | varchar(255) | 更新时间 |
| updated_by | varchar(255) | 更新人 |

### 金额

| 字段 | 类型 | 注释 |
|---|---|---|
| payable_amount | decimalv3(10,2) | 应付金额 |
| discount_amount | decimalv3(10,2) | 优惠金额 |
| actual_amount | decimalv3(10,2) | 订单总金额（**下单原始金额，不扣 SKU 取消**） |
| refund_amount | decimalv3(10,2) | 退款金额（实际已退款金额，多数取消订单此字段为 0） |
| delivery_fee | decimalv3(10,2) | 配送费 |
| packing_fee | decimalv3(10,2) | 打包费 |
| franchisee_rate | decimalv3(10,2) | 加盟商费率折扣金额 |
| payment_method | varchar(255) | 支付方式：1-银行卡余额 2-平台余额 3-组合支付 |
| currency | varchar(255) | 结算币种：默认 CNY |

### 门店 / 地址

| 字段 | 类型 | 注释 |
|---|---|---|
| store_id | bigint(20) | 门店 ID |
| store_code | varchar(255) | 门店 code |
| store_name | varchar(1024) | 门店名称 |
| store_address | varchar(1024) | 门店地址 |
| recipient_name | varchar(255) | 收货人 |
| contact_number | varchar(255) | 联系方式 |
| delivery_address | varchar(1024) | 收货地址 |
| delivery_method | int(11) | 配送方式：1-物流 2-快递 3-上门自提 |
| shipping_method | int(11) | 送货方式：0-起订 1-包邮 2-送货上门 |
| free_shipping | int(11) | 包邮：1-包邮 2-不包邮 |

### 人员 / 组织

| 字段 | 类型 | 注释 |
|---|---|---|
| manager_id | bigint(20) | 客户经理 ID |
| reviewer_id | bigint(20) | 审核人 ID |
| reviewer_name | varchar(255) | 审核人姓名 |
| region_manager | varchar(255) | 大区经理 |
| province_manager | varchar(255) | 省区经理 |
| area_manager | varchar(255) | 区域经理 |
| salesman | varchar(255) | 销售员 |
| agent_code | int(11) | 代理商 code |
| agent_name | varchar(255) | 代理商名称 |
| ratio | decimalv3(10,2) | 代理系数 |
| tll_user_id | varchar(255) | 用户 ID |
| is_push_sap | int(11) | 是否推 SAP：0 否 / 1 是 |
| sales_organization | varchar(255) | 销售组织：默认 1000-汇旺 |
| business_type | int(11) | 业务类型：如 1-首批大机器 |
| order_used_type | varchar(255) | 订单用途类型（废弃） |

## order_status 枚举

| 值 | 含义 |
|---|---|
| 1 | 待支付 |
| 2 | 已取消（支付超时） |
| 3 | 待确认 |
| 5 | 已取消（驳回） |
| 6 | 待确认（部分取消） |
| 7 | 备货中 |
| 8 | 配送中 |
| 9 | 已完成（确认收货） |
| 10 | 待递交 |
| 11 | 待推送 |
| 13 | 备货中（部分取消） |

{{< notice info "周边数据分析常用状态过滤" >}}
`订单状态 >= 3 AND 订单状态 != 5`（排除已取消和驳回的订单）。
{{< /notice >}}

## 关联表

| 表 | 关系 |
|---|---|
| [dwd_rps_tll_order_details_di]({{< ref "/schema/dwd/dwd_rps_tll_order_details_di" >}}) | 详表，`id`（头表）= `order_id`（详表） |
| [dwd_rps_tll_order_data_merge_di]({{< ref "/schema/dwd/dwd_rps_tll_order_data_merge_di" >}}) | **合并版**，已合并头+详+已扣取消量，日常查询优先用 |

## 常用查询

### 周边产品报货（与详表关联）

```sql
WITH report_order AS (
    SELECT id, order_num, order_status, order_time, store_code
    FROM tll_bi_dw.dwd_rps_tll_order_di
    WHERE pt >= '20250101' AND pt < '20260101'   -- ✅ 分区裁剪
),
summary_table AS (
    SELECT
        uo.store_code       AS 门店编号,
        rod.product_info    AS 存货名称,
        rod.actual_amount   AS 实际金额,
        rod.quantity - IFNULL(rod.cancel_quantity, 0) AS 有效数量,
        uo.order_time       AS 订单时间
    FROM report_order uo
    JOIN tll_bi_dw.dwd_rps_tll_order_details_di rod
      ON uo.id = rod.order_id
    WHERE CAST(rod.sku_code AS CHAR) LIKE '108%'
      AND uo.order_status >= 3
      AND uo.order_status != 5
      AND uo.order_time >= '2025-01-01'
      AND uo.order_time < '2026-01-01'
)
SELECT
    门店编号, 存货名称,
    DATE_FORMAT(订单时间, '%Y%m') AS 月份,
    SUM(数量)                     AS 周边报货数量,
    SUM(实际金额)                 AS 周边报货金额
FROM summary_table
GROUP BY 门店编号, 存货名称, DATE_FORMAT(订单时间, '%Y%m')
ORDER BY 门店编号, 存货名称, 月份;
```

## 注意事项

{{< notice warning "注意" >}}
1. 与详表关联时用头表 `id` = 详表 `order_id`，不是 `order_num`。
2. `order_status` 枚举里 5（驳回）和 2（支付超时取消）都是取消，过滤时注意区分。
3. 周边产品报货用 `sku_code LIKE '108%'` 筛选（详表字段）。
{{< /notice >}}

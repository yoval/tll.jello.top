---
title: "门店报货订单（合并版）"
weight: 3
---

# 门店报货订单（合并版）

门店报货订单头 + 详表合并的日表，表名 `dwd_rps_tll_order_data_merge_di`（库 `tll_bi_dw`）。

> 比 [门店报货订单头]({{< ref "/schema/dwd/dwd_rps_tll_order_di" >}}) + [门店报货信息（详表）]({{< ref "/schema/dwd/dwd_rps_tll_order_details_di" >}}) 两表 JOIN **更方便**，日常报货查询优先用这张。

## 字段查询

```sql
SELECT 
    COLUMN_NAME AS 字段名, 
    COLUMN_TYPE AS 字段类型, 
    COLUMN_COMMENT AS 字段注释 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'tll_bi_dw' 
AND TABLE_NAME = 'dwd_rps_tll_order_data_merge_di';
```

共 **18 个字段**，ETL 注释中 `actual_num` 写的是"购买数量"，实际已扣 SKU 取消量（见下方验证）。

## 粒度

每行 = **订单 × SKU**，已合并头表订单状态 + 详表商品明细 + 已扣取消量。

| 验证 | 结果 |
|---|---|
| 粒度 | 2025-01 前 15 天：155,479 行 / 8,823 订单 ≈ **17.6 行/订单** |
| `actual_num` 口径 | ✅ 已扣取消量（= 详表 `quantity - cancel_quantity`，实测 20 订单 100% 相等） |
| 金额口径 | ✅ 无取消订单：头表 `actual_amount` = `SUM(actual_num * discount_unit_price)`，零差额。**有 SKU 取消的订单：头表/详表 `actual_amount` 均为原始下单金额（不扣取消），只有 merge 推导值可靠** |
| 分区 | `pt varchar(8)` 天分区 |

## 字段说明

### 分区与主键

| 字段 | 类型 | 注释 |
|---|---|---|
| pt | varchar(8) | 天分区 |
| id | varchar(128) | 订单号（头表 id，详表 order_id 的合并键） |

### 门店与状态

| 字段 | 类型 | 注释 |
|---|---|---|
| store_code | varchar(64) | 门店编码 |
| real_store_code | varchar(128) | 真实门店 code |
| order_status | int(11) | 订单状态（见下方枚举） |
| order_type | int(11) | 订单类型：1-普通 2-待客下单 3-直营店领料 |
| order_num | string | 订单编号（业务编号） |
| cancel_order_num | string | 退款单号 |
| order_used_type | varchar(128) | 订单用途：1-首批配货 2-首批大机器 3-翻新机器 4-其他 5-首批小机器 6-拼单 |

### 金额与数量

| 字段 | 类型 | 注释 |
|---|---|---|
| order_amount | decimalv3(10,2) | 下单原始金额（**不扣取消**，等同于头表 `actual_amount`） |
| unit_price | decimalv3(10,2) | 单价 |
| discount_unit_price | decimalv3(10,2) | 折后单价 |
| actual_num | int(11) | **有效购买数量**（已扣取消，= quantity - cancel_quantity） |

{{< notice warning "金额口径关键：只有 merge 推导值可靠" >}}
**所有有效金额必须用 `actual_num * discount_unit_price` 推导**。头表 `actual_amount`、详表 `actual_amount`、详表 `refund_fee` 都是下单/退款流水值，有 SKU 取消时不会对应扣减商品金额。实测：365,109 个无取消订单零差额，1,381 个有 SKU 取消订单平均差额 170 元。
{{< /notice >}}

### 商品明细

| 字段 | 类型 | 注释 |
|---|---|---|
| sku_code | varchar(128) | 商品编码 |
| product_info | varchar(255) | 商品名称 |
| product_spec | varchar(128) | 商品规格 |
| category_name | varchar(128) | 商品分类 |

### 时间

| 字段 | 类型 | 注释 |
|---|---|---|
| create_time | varchar(128) | 创建时间 |

## order_status 枚举

| 值 | 状态 | 建议 |
|---|---|---|
| 1 | 待支付 | 排除 |
| 2 | 已取消（支付超时） | 排除 |
| 3 | 待确认 | 有效 |
| 5 | 已取消（驳回） | 排除 |
| 6 | 待确认（部分取消） | 有效 |
| 7 | 备货中 | 有效 |
| 8 | 配送中 | 有效 |
| 9 | 已完成（确认收货） | 有效 |
| 10 | 待递交 | 有效 |
| 11 | 待推送 | 有效 |
| 13 | 备货中（部分取消） | 有效 |

**常用过滤**：`order_status >= 3 AND order_status != 5`（排除待支付 + 已驳回取消）

## 关联表

| 表 | 关联键 | 用途 |
|---|---|---|
| [门店报货订单头]({{< ref "/schema/dwd/dwd_rps_tll_order_di" >}}) | `id` | 需要额外订单级字段时补充（本表只合并了 13 种状态，头表有完整时间/金额） |
| [门店报货信息（详表）]({{< ref "/schema/dwd/dwd_rps_tll_order_details_di" >}}) | `id = order_id` + `sku_code` | 需要 `cancel_quantity` / `actual_amount`（详表独有字段）时回查 |

## 常用查询

### 周边产品报货（单表，省 JOIN）

```sql
-- 周边产品按门店 × 商品 × 月份汇总
SELECT
    store_code                                                     AS 门店编号,
    product_info                                                   AS 周边产品名称,
    LEFT(pt, 6)                                                    AS 月份,
    SUM(actual_num)                                                AS 有效报货数量,
    SUM(actual_num * discount_unit_price)                          AS 报货金额
FROM tll_bi_dw.dwd_rps_tll_order_data_merge_di
WHERE pt >= '20250101' AND pt < '20260101'   -- ✅ 分区裁剪
  AND order_status >= 3 AND order_status != 5   -- 排除待支付/驳回
  AND sku_code LIKE '108%'                     -- 周边产品编码前缀
GROUP BY store_code, product_info, LEFT(pt, 6);
```

### 直营店领料订单

```sql
SELECT order_num, store_code, category_name, actual_num, discount_unit_price
FROM tll_bi_dw.dwd_rps_tll_order_data_merge_di
WHERE pt >= '20250101' AND pt < '20250201'
  AND order_type = 3;   -- 3-直营店领料
```

## 注意事项

1. **比头+详两表优先用这张**，省一次 JOIN，且 `actual_num` 已扣取消量。
2. **金额必须用 merge 推导值**：`SUM(actual_num * discount_unit_price)` 才是有效商品金额。头表 `actual_amount` 和详表 `actual_amount` 都是下单原始金额，SKU 部分取消时不会对应扣减，**不能直接拿来汇总**。实测：有 SKU 取消的订单头表金额平均多 170 元。
3. 本表不含 `cancel_quantity`（取消数量）和详表 `refund_fee`（退单金额），需要这两个字段时回详表。
4. `create_time` 是 varchar，字符串比较依赖存储格式，转 DATE 用 `CAST(STR_TO_DATE(create_time, '%Y-%m-%d %H:%i:%s') AS DATE)`。

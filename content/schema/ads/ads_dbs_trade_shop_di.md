---
title: "门店销售（来源渠道）"
weight: 2
---

# 门店销售（来源渠道）

门店日汇总表，粒度为 **门店 × 日期 × 渠道**，表名 `tll_bi_dw.ads_dbs_trade_shop_di`。

{{< notice info "定位" >}}
按**订单来源渠道**汇总的门店销售数据。

和 [支付渠道版]({{< ref "/schema/ads/ads_dbs_trade_shop_pay_channel_di" >}}) 相比：两表**总额差异 < 0.05%**，但渠道口径不同——本表按来源归并（如小程序汇总成一条），支付渠道版按原始支付渠道归并（归并规则来自 [渠道映射表]({{< ref "/schema/biz/渠道映射表" >}})，小程序拆成多个）。
{{< /notice >}}

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

### 维度字段

| 字段名 | 类型 | 注释 |
|---|---|---|
| business_date | varchar(20) | 日期 |
| prov_id / prov_name | varchar(100) | 省份编码 / 名称 |
| city_id / city_name / city_level | varchar(100) | 城市编码 / 名称 / 等级 |
| district_id / district_name | varchar(100) | 区县编码 / 名称 |
| bussiness_type | varchar(100) | 业务类型 |
| anal_type | varchar(100) | 分析类型（`到家` / `到店`） |
| shop_id | varchar(20) | 门店统计 id |
| channel_name | varchar(100) | 渠道（来源渠道） |
| franchisee_type | varchar(20) | 门店类型 |
| pt | varchar(20) | 时间分区 |

### 指标字段

| 字段名 | 类型 | 注释 |
|---|---|---|
| total_amount | decimalv3(16,2) | 流水金额 |
| pay_amount | decimalv3(16,2) | 实收金额 |
| food_sales_amount | decimalv3(16,2) | 菜品销售 |
| total_mealFee | decimalv3(16,2) | 总餐盒费 |
| freight_amount | decimalv3(16,2) | 配送费（商家配送） |
| dp_total_amount | decimalv3(16,2) | 商品流水金额 |
| discount_amount | decimalv3(16,2) | 优惠金额 |
| item_scrap_amount | decimalv3(16,2) | 报废金额 |
| order_count | bigint(20) | 订单量 |
| dp_item_count | bigint(20) | 商品销量 |

## anal_type × channel_name 枚举值

```sql
SELECT DISTINCT anal_type, channel_name
FROM ads_dbs_trade_shop_di;
```

**大渠道 / 中渠道分类参考 [支付渠道分组]({{< ref "/reference/渠道分组" >}})。**

{{< notice info "业务背景" >}}
历史上用**美团 POS 收银系统**，现在逐步切到**自研收银**。

**美团 POS 的数据局限**：同一个支付渠道（如抖音团购券）可能来自 POS 收银、自营外卖、小程序多个入口，但从美团接口拿回来的数据**区分不了来源**——原始数据粒度不够，ETL 只能做模糊归并。这是两表渠道名对不上的根本原因，等全切自研 POS 后自动解决。
{{< /notice >}}

### 线上外卖（anal_type = 到家）

| 大渠道 | 中渠道 | channel_name | 说明 |
|---|---|---|---|
| 线上外卖 | 美团外卖 | 美团外卖 | |
| 线上外卖 | 淘宝闪购 | 淘宝闪购 | 🔸 原名"饿了么外卖"；跨期查询用 `IN ('饿了么外卖', '淘宝闪购')` 兼容历史数据 |
| 线上外卖 | 京东外卖 | 京东外卖 | 🔸 **含美团 POS 的"自营外卖"**（京东占绝大多数，实践里自营外卖 ≈ 京东外卖） |
| 线上外卖 | — | 自营外卖 | 🔸 美团 POS 数据粒度不够，无法区分来源的模糊归并项 |

### 到店（anal_type = 到店）

| 大渠道 | 中渠道 | channel_name | 说明 |
|---|---|---|---|
| pos小程序 | pos | pos收银 | |
| pos小程序 | 甜啦啦小程序 | 微信小程序 | |
| pos小程序 | 甜啦啦小程序 | 支付宝小程序 | |
| pos小程序 | — | 小程序 | 🔸 与微信/支付宝并存，疑似历史遗留汇总值 |
| 线上团购 | 抖音团购 | 抖音团购 | |
| 线上团购 | 抖音团购 | 抖音小程序（核销工具） | |
| 线上团购 | 高德团购 | 高德团购 | |
| 线上团购 | 快手团购 | 快手团购 | |
| 线上团购 | 美团团购 | 美团/大众点评团购 | |
| 线上团购 | 美团团购 | 美团在线点 | |

共 **14 条**：到家 4 条 + 到店 10 条。

### 渠道分组（4 组归并）

实际分析时把 14 条渠道归并为 **4 组**：

| 分组 | channel_name | 条数 |
|---|---|---|
| 外卖 | 美团外卖、京东外卖、自营外卖、淘宝闪购 | 4 |
| 小程序 | 微信小程序、支付宝小程序、小程序 | 3 |
| POS | pos收银 | 1 |
| 团购 | 美团/大众点评团购、美团在线点、抖音团购、抖音小程序（核销工具）、快手团购、高德团购 | 6 |

4+3+1+6 = 14，全量覆盖。

```sql
SELECT 
    CASE
        WHEN channel_name IN ('美团外卖', '京东外卖', '自营外卖', '淘宝闪购') THEN '外卖'
        WHEN channel_name IN ('微信小程序', '支付宝小程序', '小程序') THEN '小程序'
        WHEN channel_name = 'pos收银' THEN 'POS'
        WHEN channel_name IN ('美团/大众点评团购', '美团在线点', '抖音团购',
                              '抖音小程序（核销工具）', '快手团购', '高德团购') THEN '团购'
    END             AS 渠道分组,
    SUM(total_amount) AS 流水,
    SUM(order_count)  AS 订单量
FROM tll_bi_dw.ads_dbs_trade_shop_di
WHERE business_date LIKE '2026%'
GROUP BY 渠道分组
ORDER BY 流水 DESC;
```

{{< notice info "与上方大渠道口径的区别" >}}
本分组是独立的 4 组归并口径：**淘宝闪购归入外卖**（不是团购），美团在线点、抖音小程序（核销工具）归入团购。两套口径按场景选用，别混用。枚举值写全（不用 ELSE），新增渠道会以 NULL 暴露出来。
{{< /notice >}}

{{< notice warning "自营外卖口径" >}}
**shop_di 的"自营外卖"是美团 POS 数据粒度不够的产物**：同一个支付渠道可能来自 POS、自营外卖、小程序多个入口，但美团接口返回的原始数据分不清来源，ETL 只能做模糊归并。

实践中京东外卖占自营外卖的绝大多数，所以**可以近似认为 shop_di 的自营外卖 ≈ 京东外卖**：

```
shop_di.京东外卖     ≈ 自研 POS 京东外卖
shop_di.自营外卖     ≈ 美团 POS 京东外卖（混淆项）
─────────────────────────────────────
shop_di 到家 合计    = pay_channel 到家 合计（两表总额对得上）
```

后续全切自研 POS 后，自营外卖这个模糊项会消失。
{{< /notice >}}

## 指标口径

| 指标 | 口径 |
|---|---|
| `total_amount` | **流水**：门店口径营业收入，含菜品销售 + 餐盒费 + 配送费 |
| `dp_total_amount` | **商品流水**：只统计商品部分，不含餐盒费、配送费 |
| `pay_amount` | **实收**：扣掉优惠后的实际收款 |
| `discount_amount` | 优惠金额 |
| `order_count` / `dp_item_count` | 订单量 / 商品销量（粒不同，汇总时别混用） |

{{< notice warning "流水 ≠ 商品流水" >}}
`total_amount`（流水）总是 **大于** `dp_total_amount`（商品流水），差额就是 `total_mealFee`（餐盒费）+ `freight_amount`（配送费）。

到家类渠道差额率约 8~9%，到店类渠道几乎为 0（到店没有配送费）。
{{< /notice >}}

## 常用查询

### 月度 × 渠道流水

```sql
SELECT 
    DATE_FORMAT(business_date, '%Y-%m') AS 月份,
    anal_type                           AS 分析类型,
    channel_name                        AS 渠道,
    SUM(total_amount)                   AS 流水,
    SUM(order_count)                    AS 订单量
FROM tll_bi_dw.ads_dbs_trade_shop_di
WHERE business_date LIKE '2026%'
GROUP BY 月份, anal_type, channel_name
ORDER BY 月份, anal_type, channel_name;
```

### 到家 / 到店汇总

```sql
SELECT 
    DATE_FORMAT(business_date, '%Y-%m') AS 月份,
    anal_type                           AS 分析类型,
    SUM(total_amount)                   AS 流水
FROM tll_bi_dw.ads_dbs_trade_shop_di
WHERE business_date LIKE '2026%'
GROUP BY 月份, anal_type
ORDER BY 月份, anal_type;
```

### 流水与商品流水差额（同表内即可算）

```sql
SELECT 
    DATE_FORMAT(business_date, '%Y-%m')        AS 月份,
    SUM(total_amount)                          AS 门店流水,
    SUM(dp_total_amount)                       AS 商品流水,
    ROUND(1 - SUM(dp_total_amount) / SUM(total_amount), 4) AS 差额率
FROM tll_bi_dw.ads_dbs_trade_shop_di
WHERE business_date LIKE '2026%'
GROUP BY 月份
ORDER BY 月份;
```

营业天数相关的完整版查询见 [来源渠道月流水与营业天数]({{< ref "/queries/来源渠道月流水与营业天数" >}})。

## 关联表

| 表 | 关系 |
|---|---|
| [ads_dbs_trade_food_di]({{< ref "/schema/ads/ads_dbs_trade_food_di" >}}) | 商品维度明细 |
| [ads_dbs_trade_shop_pay_channel_di]({{< ref "/schema/ads/ads_dbs_trade_shop_pay_channel_di" >}}) | 同源门店流水（总额一致，渠道 ETL 不同） |
| [渠道口径对比：来源 × 支付渠道]({{< ref "/reference/支付渠道对比" >}}) | 两表总额对比（仅总额，不对比渠道） |

## 注意事项

{{< notice warning "注意" >}}
1. `total_amount` 是流水，含餐盒费、配送费；商品流水请用 `dp_total_amount`，不要混用。
2. 与支付渠道版 ETL 链路不同，渠道名不可直接对比或 JOIN。
3. `小程序` / `微信小程序` / `支付宝小程序` 三条并存，汇总到店流水时注意去重。
4. 门店销售流水对外输出统一走 [支付渠道版]({{< ref "/schema/ads/ads_dbs_trade_shop_pay_channel_di" >}})，中台驾驶舱以其为基准。
{{< /notice >}}

## 补充说明：旧版表

{{< notice info "旧版表：只用于查 2025 年以前的数据" >}}
本表在**旧版服务器**上还有个**同名旧版**（表名也是 `ads_dbs_trade_shop_di`，区别在服务器/连接），只用于查询 2025 年以前的数据。字段与渠道口径都不同：

- `business_date` 是 **bigint**（新版是 varchar），过滤用数值范围，如 `business_date >= 20240101 AND business_date < 20250101`
- 门店字段是 `stat_shop_id` / `stat_shop_name`（新版是 `shop_id`）
- 渠道只有 **5 个值**，分组更简单：

  | channel_name | 分组 |
  |---|---|
  | 美团外卖、饿了么外卖、自营外卖 | 外卖 |
  | pos | POS |
  | 小程序 | 小程序 |
- 旧版里还是"饿了么外卖"（2025 年才更名淘宝闪购）
- 自带 `_last_day` / `_last_week` / `_last_year` 同期对比列，另有 `report_amount`（报货金额）、`time_name`（时段）、`platform`（平台）等新版没有的字段
{{< /notice >}}

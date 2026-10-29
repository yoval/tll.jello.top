---
title: "门店管理表"
weight: 1
---

# 门店管理表

中台同步的 OA 门店主数据日表，粒度为门店，表名 `dim_oas_formmain_0145_df`（库 `tll_bi_dw`）。

## 字段查询

```sql
SELECT 
    COLUMN_NAME AS 字段名, 
    COLUMN_TYPE AS 字段类型, 
    COLUMN_COMMENT AS 字段注释 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'tll_bi_dw' 
AND TABLE_NAME = 'dim_oas_formmain_0145_df';
```

## 字段说明

| 列名                  | 数据类型         | 注释                         |
| --------------------- | ---------------- | ---------------------------- |
| shop_oneid            | varchar(255)     | 门店唯一编码                 |
| shop_id               | varchar(255)     | 门店id                       |
| shop_name             | varchar(255)     | 门店名称                     |
| oa_shop_code          | varchar(255)     | OA门店编号                   |
| oa_shop_name          | varchar(255)     | OA门店名称                   |
| shop_type             | varchar(255)     | 门店类型                     |
| shop_status           | varchar(255)     | 门店状态                     |
| busi_status           | varchar(255)     | 运营状态                     |
| open_date             | varchar(255)     | 开业日期                     |
| shop_open_time        | varchar(255)     | 营业时间                     |
| region_name           | varchar(255)     | 所属大区                     |
| region_manager_name   | varchar(255)     | 大区经理名称                 |
| prov_manager_name     | varchar(255)     | 省经理名称                   |
| district_manager_name | varchar(255)     | 区域经理名称                 |
| supervisor_name       | varchar(255)     | 督导                         |
| shop_addr             | varchar(255)     | 门店地址                     |
| prov_name             | varchar(255)     | 所属省份                     |
| prov_id               | varchar(255)     | 所属省份id                   |
| city_name             | varchar(255)     | 所属城市                     |
| city_id               | varchar(255)     | 所属城市id                   |
| district_name         | varchar(255)     | 所属区县                     |
| district_id           | varchar(255)     | 所属区县id                   |
| area_division         | varchar(255)     | 所属行政区划                 |
| busi_area_level       | varchar(255)     | 商圈等级                     |
| send_whse             | varchar(255)     | 发货仓库                     |
| cont_status           | varchar(255)     | 合同状态(初签、过户、迁址等) |
| shop_area             | varchar(255)     | 经营面积                     |
| license_name          | varchar(255)     | 营业执照名称                 |
| license_person        | varchar(255)     | 营业执照法人                 |
| license_phone         | varchar(255)     | 法人号码                     |
| license_addr          | varchar(255)     | 营业执照地址                 |
| u8c_cus_id            | varchar(255)     | U8C客商编码                  |
| regist_date           | varchar(255)     | 登记日期                     |
| close_shop_date       | varchar(255)     | 闭店日期                     |
| contract_sign_date    | varchar(255)     | 签约日期                     |
| contract_id           | varchar(255)     | 合同编号                     |
| contract_start_date   | varchar(255)     | 合同开始日期                 |
| contract_end_date     | varchar(255)     | 合同结束日期                 |
| load_time             | varchar(255)     | 中台数据加工时间             |
| pt                    | varchar(255)     | 天分区                       |
| shop_level            | varchar(5)       | 门店等级                     |
| agent_code            | varchar(10)      | 代理商编码                   |
| agent_name            | varchar(255)     | 代理商名称                   |
| rebate_ratio          | decimalv3(10, 2) | 代理商返利系数               |
| sap_shop_id           | varchar(255)     | sap门店编码                  |
| rps_discount          | varchar(255)     | 报货等级                     |
| expand_personnel      | varchar(200)     |                              |
| busi_district_type    | varchar(255)     | 商圈类型                     |
| direct_store_manager  | varchar(255)     | 直营店经理                   |
| street                | varchar(255)     | 街道                         |
| city_level            | varchar(255)     | 所属城市等级                 |
| registrant            | varchar(128)     | 登记人                       |
| shop_rent             | decimalv3(10, 2) | 门店租金                     |
| if_subsidy            | varchar(8)       | 是否补贴                     |
| if_agent_area         | varchar(8)       | 是否属于代理区域             |
| first_sign_date       | varchar(128)     | 初签日期                     |
| first_sign_name       | varchar(128)     | 初签人名称                   |
| shop_short_name       | varchar(255)     | 门店简称                     |

## 常用查询

全量门店（最新分区，含在营/闭店/解约全状态，约 11,973 家）：

```sql
SELECT *
FROM tll_bi_dw.dim_oas_formmain_0145_df
WHERE pt = (
    SELECT MAX(pt)
    FROM tll_bi_dw.dim_oas_formmain_0145_df
)
ORDER BY shop_oneid;
```

`pt` 为 varchar 天分区（`YYYYMMDD`），按字符串比较即为时间序，直接 `MAX(pt)` 即可。该表仅保留最新一个分区，历史快照不落库。

完整示例、常用列与参数调整见 [中台门店全量查询]({{< ref "/queries/中台门店全量查询" >}})。

## 注意事项

{{< notice warning "注意" >}}
通常使用自己维护的门店管理表（`shop_current`，见 [门店信息管理]({{< ref "/projects/daily/门店信息管理" >}})），不使用这张中台表。
{{< /notice >}}

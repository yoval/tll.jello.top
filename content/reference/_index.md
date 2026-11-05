---
title: 参考资料
weight: 80
bookCollapseSection: true
---

长效参考页：渠道分组、口径对比、涉税疑点规则等跨表概念与规则说明。

| 页面 | 内容 |
|---|---|
| [支付渠道分组]({{< ref "/reference/渠道分组" >}}) | payment_channels → 到店（pos、小程序、团购）/ 到家（外卖）两档，附饿了么更名淘宝闪购说明 |
| [来源渠道分组]({{< ref "/reference/来源渠道分组" >}}) | channel_name → 到店 / 到家两档，原始 → 中渠道 → 大渠道三级归并 |
| [渠道口径对比：来源 × 商品流水]({{< ref "/reference/来源渠道对比" >}}) | shop_di.total_amount vs food_di.dp_total_amount，配送费包装费差额、外卖 93% 换算系数 |
| [渠道口径对比：来源 × 支付渠道]({{< ref "/reference/支付渠道对比" >}}) | shop_di vs pay_channel_di，总额一致但 ETL 归并不同，不比渠道只比总额 |
| [平台涉税信息报送疑点规则]({{< ref "/reference/疑点规则" >}}) | 税务校验疑点 20 条，含指标说明、应对策略、加工频率（日频 6 条 / 月频 14 条） |

---
title: 参考资料
weight: 80
bookCollapseSection: true
---

长效参考页：渠道分组、口径对比等跨表概念说明。

| 页面 | 内容 |
|---|---|
| [支付渠道分组]({{< ref "/reference/渠道分组" >}}) | payment_channels → POS / 小程序 / 外卖 / 团购 四类，附饿了么更名淘宝闪购说明 |
| [渠道口径对比：来源 × 商品流水]({{< ref "/reference/来源渠道对比" >}}) | shop_di.total_amount vs food_di.dp_total_amount，配送费包装费差额、外卖 93% 换算系数 |
| [渠道口径对比：来源 × 支付渠道]({{< ref "/reference/支付渠道对比" >}}) | shop_di vs pay_channel_di，总额一致但 ETL 归并不同，不比渠道只比总额 |

---
title: 玩云服务的一些经验和心得
date: 2025-11-30 21:10
tags: [云服务]
index_img: https://cdn.dwj601.cn/images/20251130210905323.svg
---

提供自定义的服务真的是一件非常酷的事！

> 大一的时候因为大创开始接触云，由于阿里云会送 300 元学生优惠券，就入坑了阿里云，所以下面的大部分服务都是阿里云提供的，多样性不足，见谅 : D

## 我的云服务

我的云服务架构：

![我的云服务架构](https://cdn.dwj601.cn/images/my-cloud-service-architecture.svg)

对外提供的服务：

|       域名        |   定位   |       部署方案       |      备注      |
| :---------------: | :------: | :------------------: | :------------: |
|  `www.dwj601.cn`  | 个人门户 |    私有 OSS + CDN    | 其他服务的入口 |
| `blog.dwj601.cn`  | 生活博客 |    私有 OSS + CDN    |       -        |
| `wiki.dwj601.cn`  | 技术博客 |    私有 OSS + CDN    |       -        |
|  `cdn.dwj601.cn`  | 资源分发 |    私有 OSS + CDN    |       -        |
| `memos.dwj601.cn` |  备忘录  | ECS + Docker + Nginx |   暂时个人用   |

涉及到的计费类型：

| 产品           | 计费方案                                                     |
| -------------- | ------------------------------------------------------------ |
| 域名 (Domain)  | 根据后缀类型按年计费                                         |
| 云服务器 (ECS) | 机器按年计费、流量按量计费（大部分区域的机器是 0.8 元/GB）   |
| 对象存储 (OSS) | 存储 `*` 按年计费、流量 `*` 按量计费（白天 0.5 元/GB，凌晨 0.25 元/GB）、CDN 回源流出流量 `*` 按量计费（0.15 元/GB） |
| 内容分发 (CDN) | 流量 `*` 按量计费（大陆地区 0.24 元/GB，其他地区价格较高）、HTTPs 请求 `*` 按次计费（0.05 元/万次，每月有免费额度）、实时日志推送按量计费（0.01 元/万条） |
| 日志服务 (SLS) | 流量按量计费（0.4 元/GB）、存储按量计费（存 30 天免费）      |

*注：

- 打 `*` 表示可买资源包，单价更低。至于是否购买，取决于具体的业务场景；
- [ECS](https://help.aliyun.com/zh/ecs/public-bandwidth) 和 [OSS](https://help.aliyun.com/zh/oss/traffic-fees) 的流量计费只涉及公网流出流量，CDN 默认只有公网流出流量；
- 价格计算表：[ECS](https://www.aliyun.com/price/product?spm=a2c4g.11186623.0.0.76a12330rmr8iS#/ecs/detail/vm)、[OSS](https://www.aliyun.com/price/product#/oss/detail/oss)、[CDN](https://www.aliyun.com/price/product#/cdn/detail/cdn)、[SLS](https://www.aliyun.com/price/product#/sls/detail/sls)；
- 阿里云 CDN 的实时日志推送服务和 SLS 服务是绑定的（CDN 把日志实时推送给 SLS），所以想要监控阿里云 CDN，就不得不掏「实时日志推送」和「SLS」两份钱 😡，经过我的分析，这个价格并不便宜。

## 部署方案选型

### 静态内容

我目前接触到的：

1. ECS + Nginx (+ CDN)
2. 公有 OSS Bucket (+ CDN)
3. 私有 OSS Bucket + CDN

在阿里云体系中，我目前选择上述第三种方法。除了初始配置有点麻烦以外，优点如下：

- 更快：CDN 可以无视源服务器位置进行分布式加速；
- 更省：CDN 的流量费显著低于 ECS 和 OSS；
- 更安全：CDN 可以轻松配置 IP 黑名单并进行流量控制。

### 动态服务

我目前接触到的：

1. 手动配置环境 + Nginx
2. Docker + Nginx

我目前选择上述第二种方法。缺点几乎没有，优点如下：

- 更稳定：只要服务器性能足够，理论上任意服务都可以部署；
- 更普适：部署侧无需关心依赖，只需要按需设置参数即可。

---
title: 玩云服务的一些经验和心得
date: 2025-11-30 21:10
tags: [云服务]
index_img: https://cdn.dwj601.cn/images/my-cloud-service-architecture.svg
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

## 部署实施细节

### 私有 OSS + 阿里云 CDN

关于 OSS：购买一个 OSS 存储套餐后，创建一个存储桶（默认私有），后续把数据传输（GUI、CLI）到该桶即可。

关于 CDN：使用阿里云 CDN 配合阿里云 OSS 的话，流量费会少一点。主要步骤：

第一步：设置 CDN 加速域名，例如本站就是 `blog.dwj601.cn`；

第二步：设置源站信息，此时可以选择私有 OSS 桶对应的域名：

![设置源站信息，选择私有 OSS 桶对应的域名](https://cdn.dwj601.cn/images/20260312094600741.png)

第三步：进入域名解析，把自定义域名解析到阿里云提供的 CDN 加速域名上：

![把自定义域名解析到阿里云提供的 CDN 加速域名上，记录类型为 CNAME](https://cdn.dwj601.cn/images/20260312094849964.png)

最后在 CDN 域名列表给这个域名配置一些规则即可，常见的规则有：

- 安全规则（限流、IP 黑白名单等）；

- 主页规则（当 OSS 被设置为静态网站时，首页默认需要显式访问 `example.com/index.html`，默认无法访问首页的 index.html，需要重写一下 URL 访问规则）

    ![重写 URL 访问规则](https://cdn.dwj601.cn/images/20260312095541113.png)

- SSL 证书配置

### 使用 Docker 部署 memos

[memos](https://github.com/usememos/memos) 是一款开源可自托管的备忘录系统，对硬件的要求极小。

部署命令：

```bash
docker volume create memos_prod

docker run -d \
  --name memos_0.26.2 \
  -p 5230:5230 \
  -v memos_prod:/var/opt/memos \
  neosmemo/memos:0.26.2
```

使用 OSS 兼容 S3 配置对象存储：

![使用 OSS 兼容 S3 对象存储的配置](https://cdn.dwj601.cn/images/20260228223809546.png)

OSS 与 S3 的主要区别就是 Endpoint，OSS 的 Endpoint 见 [对应文档](https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints) 中的内容。

文件路径模板文档没有详细说明，阅读 [源码](https://github.com/usememos/memos/blob/main/server/router/api/v1/attachment_service.go#L490C1-L517C2) 可以知道有 `filename`、`timestamp` 等选项，读者可自行配置。我的路径配置为：

```text
memos/{year}{month}{day}{hour}{minute}{second}_{filename}
```

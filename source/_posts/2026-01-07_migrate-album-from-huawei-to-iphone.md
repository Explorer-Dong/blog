---
title: 将相册从华为迁移到 iPhone
date: 2026-01-07 22:19
tags: [3uTools, 坚果云]
index_img: https://cdn.dwj601.cn/images/20260107223907626.png
---

大学开学前买的华为 Hi nova 11，三年多用下来很卡了，监视内存也看不出什么猫腻，就换了 iPhone 17 基础款，很多数据就都没有同步，拖拖拉拉一个多月总算动手开始同步相册。这里介绍一下同步方法。

尝试过 [iReaShare Phone Transfer](https://www.softpedia.com/get/Mobile-Phone-Tools/Others/iReaShare-Phone-Transfer.shtml#download)，它的方法是在电脑安装该软件，然后两部手机同时连接电脑进行传输，数据不会持久化在电脑。可惜我的华为不能被正常识别到，只能放弃该方案。读者可以优先尝试该方案。

既然端到端的方案行不通，就试试两阶段法吧 : )

## 阶段一：华为 :arrow_right: Windows

我一直有备份数据的习惯，相册方面我用的是坚果云同步软件。所以「华为 $\to$ Windows」这一步的数据传输就省略了，直接在电脑安装坚果云客户端后把所有相片下载下来即可。

读者可以尝试使用其他的手段将相册从源手机移动到电脑。

## 阶段二：Windows :arrow_right: iPhone

在 [reddit](https://www.reddit.com/r/ios/comments/1goxfxo/best_way_to_transfer_large_amount_of_photos_to/?tl=zh-hans) 上刷到有人推荐使用 3uTools，尝试以后发现确实可以。

电脑 [安装 3uTools](https://www.3u.com/) 后，启动后界面如下：

![3uTools 启动后界面](https://cdn.dwj601.cn/images/20260107223907626.png)

使用数据线连接 Windows 和 iPhone 后，软件信息界面如下：

![使用数据线连接 Windows 和 iPhone 后 3uTools 的 Information 界面](https://cdn.dwj601.cn/images/20260107224115198.png)

之后选择左侧 Photos 选项后点击 import，选择电脑中持久化的相册文件，即可导入 iPhone：

![导入 iPhone 中](https://cdn.dwj601.cn/images/20260107224537798.png)


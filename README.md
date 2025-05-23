## 内容简介

个人博客网站，写点生活感悟。

## 更新日志

2025.01.28

⭐ 更换网站框架，从 Hexo-Fluid 迁移至 MkDocs-Material。将原来的网站解耦为「学习」与「生活」两部分。迁移的根本原因：MkDocs-Material 支持并列展示内容块；以及我的网站定位其实是技术文档并非博客，而 MkDocs-Material 就是为技术文档而量身打造的。

25.01.19

:fire: **增强：全站检索功能** - 放弃静态加载检索文件，使用阿里云 OSS 存储服务。提升网站全文检索体验。

25.01.04

:gear: **配置：取消页面图片懒加载** - 便于通过大纲精准定位。提升用户阅读体验。

24.10.06

:bookmark_tabs: **丰富：站长信息和心语页面** - 删除「友链」页面，新增「关于」页面，正确使用个人网站引导；新增心语页面。提升网站信息完整度。

24.04.07

:fire: **增强：将网站部署至国内云服务器** - 解决国内访问速度慢的问题。提升用户体验。

24.04.02

:sparkles: **新增：网站 ICP 备案信息** - 网站底部新增 [ICP 备案信息查询](https://beian.miit.gov.cn/) 窗口。提升网站可信度。

24.03.28

:fire: **增强：图片加载效率** - 放弃静态加载图片资源，使用阿里云 OSS 图床服务。提升网站浏览与文章阅读体验。

24.03.27

:sparkles: **新增：emojis 功能** - 通过 hexo 的 [hexo-filter-github-emojis](https://github.com/crimx/hexo-filter-github-emojis) 插件实现 emojis 渲染功能 :sunglasses:。提升文章阅读体验。

:sparkles: **新增：评论功能** - 使用 [utterances](https://utteranc.es/) 的第三方评论服务，基于 GitHub Issue 实现。提升文章可信度。

24.03.15

:gear: **配置：折叠标签功能** - 通过 hexo-fluid 的折叠标签实现，折叠相对不重要的内容，凸显重点内容。提升文章阅读体验。

24.03.09

:sparkles: **新增：网站流量统计服务** - 后端使用 [百度统计](https://tongji.baidu.com/web5/welcome/login) 服务，前端使用 [不蒜子](https://busuanzi.ibruce.info/) 服务。提升网站内容可信度。

24.03.07

:sparkles: **新增：自定义网站域名** - 购买长期可用顶级域名 [dwj601.cn](https://dwj601.cn/) 并配置二级域名 [blog.dwj601.cn](https://blog.dwj601.cn) 定位到当前博客网站。便于网站推流。

24.03.03

:bug: **修复：文章更新时间无法显示的问题** - 放弃 `.github/workflows/deploy.yml` 方案，本地手动部署。

24.03.01

:bug: **修复：文章无法更新的问题** - 通过修改 github 的自动部署配置解决。

24.02.27

:gear: **配置：文章二级目录** - 通过 hexo 的层叠目录实现。提升文章分类检索速度。

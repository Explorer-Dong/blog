# ============================================================
echo "备份到 GitHub"
git push

# ============================================================
echo "生成静态页面"
hexo clean
hexo generate

# ============================================================
echo "部署到 Server"
# 本地压缩传输
tar -czf blog.tar.gz public/
sftp git@47.100.217.241 << EOF
put -r blog.tar.gz /home/web/
bye
EOF
rm blog.tar.gz

# 云端解压配置
ssh git@47.100.217.241 << EOF
cd /home/web/
rm -rf blog/
mkdir blog/
chown -R git:git blog/
tar -xzf blog.tar.gz -C blog/ --strip-components=1
rm blog.tar.gz
exit
EOF

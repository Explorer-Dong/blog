# ============================================================
echo -e "备份到 GitHub ...\n"
git push

# ============================================================
echo -e "\n生成静态页面 ...\n"
hexo clean
hexo generate

# ============================================================
echo -e "\n部署到 Server ...\n"

# 变量配置
REMOTE_USER="git"
REMOTE_HOST="47.100.217.241"
REMOTE_DIR="/home/web"
LOCAL_SOURCE_DIR="public"
ARCHIVE_NAME="blog.tar.gz"
TARGET_DIR_NAME="blog"

# 本地压缩传输
tar -czf $ARCHIVE_NAME $LOCAL_SOURCE_DIR/
sftp ${REMOTE_USER}@${REMOTE_HOST} << EOF
put -r $ARCHIVE_NAME $REMOTE_DIR/
bye
EOF
rm $ARCHIVE_NAME

# 云端解压配置
ssh ${REMOTE_USER}@${REMOTE_HOST} << EOF
cd $REMOTE_DIR
rm -rf $TARGET_DIR_NAME/
mkdir $TARGET_DIR_NAME/
chown -R ${REMOTE_USER}:${REMOTE_USER} $TARGET_DIR_NAME/
tar -xzf $ARCHIVE_NAME -C $TARGET_DIR_NAME/ --strip-components=1
rm $ARCHIVE_NAME
exit
EOF

# backup to GitHub
git push

# deploy to Aliyun OSS
hexo clean
hexo generate
ossutil rm -r oss://blog-web-shanghai/ -f
ossutil cp -r ./public/ oss://blog-web-shanghai/
hexo clean

git push

hexo clean
hexo generate
ossutil rm -r oss://blog-web-shanghai/ -f
ossutil cp -r ./public/ oss://blog-web-shanghai/

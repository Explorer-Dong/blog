echo "部署到 GitHub Pages..."
git push


echo "部署到 Aliyun Server..."
hexo clean
hexo generate
hexo deploy
ossutil cp e:/notes/Blog/public/local-search.xml oss://dwj-oss/search-files/ --force

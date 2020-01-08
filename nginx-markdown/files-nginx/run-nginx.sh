docker rm -f files-nginx
docker run --name files-nginx \
  -p 88:88 \
  -v /Users/luoyanke/huacloud/git/github/my-docker/nginx-markdown/files-nginx:/data/files/ \
  -v /Users/luoyanke/huacloud/git/github/my-docker/nginx-markdown/files-nginx/nginx.conf:/etc/nginx/nginx.conf \
  -v /Users/luoyanke/huacloud/git/github/my-docker/nginx-markdown/files-nginx/conf.d:/etc/nginx/conf.d \
  -v /Users/luoyanke/huacloud/git/github/my-docker/nginx-markdown/files-nginx/:/var/log/nginx/ \
  -v /Users/luoyanke/huacloud/git/github/my-docker/nginx-markdown/files-nginx/mime.types:/etc/nginx/mime.types \
  -d nginx-md:0.1 

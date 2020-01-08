FROM nginx:1.17.6

LABEL maintainer="NGINX Docker with markdown module"

WORKDIR /root

RUN apt-get install apt-transport-https

#更新源
#RUN echo " deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free " >> /etc/apt/sources.list && \
#    echo " # deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free " >> /etc/apt/sources.list && \
#    echo " deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free " >> /etc/apt/sources.list && \
#    echo " # deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free " >> /etc/apt/sources.list && \
#    echo " deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free " >> /etc/apt/sources.list && \
#    echo " # deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free " >> /etc/apt/sources.list && \
#    echo " deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free " >> /etc/apt/sources.list && \
#    echo " # deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free " >> /etc/apt/sources.list

RUN apt-get update --fix-missing

# 安装所需的依赖
RUN apt-get install -y libmarkdown2-dev wget unzip gcc libpcre3 libpcre3-dev openssl libssl-dev zlib1g-dev make --fix-missing

# 下载资源包
RUN wget https://nginx.org/download/nginx-1.17.6.tar.gz -O ~/nginx-1.17.6.tar.gz && \
    tar zxvf nginx-1.17.6.tar.gz && \
    wget https://github.com/jbfavre/ngx-markdown-module/archive/mdfilter-0.1.zip -O ngx-markdown-module.zip && \
    unzip ngx-markdown-module.zip

WORKDIR /root/nginx-1.17.6

#先关闭已启动的服务
#RUN nginx -s stop

# nginx -V 查看信息并拷贝，新增模块追加到这些信息后面
RUN  ./configure  --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx  \
    --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log \
     --pid-path=/var/run/nginx.pid  \
     --lock-path=/var/run/nginx.lock  \
     --http-client-body-temp-path=/var/cache/nginx/client_temp  \
     --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
     --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
     --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
     --http-scgi-temp-path=/var/cache/nginx/scgi_temp  \
     --user=nginx \
      --group=nginx  \
      --with-compat --with-file-aio --with-threads --with-http_addition_module  \
      --with-http_auth_request_module --with-http_dav_module --with-http_flv_module  \
      --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module  \
      --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module  \
      --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module  \
      --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module  \
      --with-stream_ssl_module --with-stream_ssl_preread_module  \
      --with-cc-opt='-g -O2 -fdebug-prefix-map=/data/builder/debuild/nginx-1.17.6/debian/debuild-base/nginx-1.17.6=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC'  \
       --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' \
        --add-module=/root/ngx-markdown-module-mdfilter-0.1/ngx-md-filter-module \
        && make \
        &&  cp -rfp /root/nginx-1.17.6/objs/nginx /usr/sbin/nginx

WORKDIR /root

RUN rm -rf nginx-1.17.6.tar.gz nginx-1.17.6 ngx-markdown-module.zip  ngx-markdown-module-mdfilter-0.1

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
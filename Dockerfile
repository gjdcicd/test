# 创建redis容器
# docker pull redis
FROM redis
RUN echo "deb http://mirrors.aliyun.com/debian/ buster main\n\
deb http://mirrors.aliyun.com/debian-security buster/updates main\n\
deb http://mirrors.aliyun.com/debian/ buster-updates main">/etc/apt/sources.list
RUN apt-get update
# docker build -f DOCKERFILE -t uredis .
# docker run --name redis --network host -dit uredis /bin/bash
# docker exec -it redis /bin/bash

FROM debian as build
WORKDIR /root
RUN sed -i -e 's/deb.debian.org/mirrors.ustc.edu.cn/g' -e 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get -y update && apt-get -y install git make gcc && \
    git clone --branch master --single-branch https://gitee.com/asvex/vlmcsd.git && \
    cd vlmcsd && make

FROM busybox
WORKDIR /root/
COPY --from=build /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd
EXPOSE 1688/tcp
CMD [ "/usr/bin/vlmcsd", "-D", "-d" ]

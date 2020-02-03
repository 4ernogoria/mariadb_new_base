FROM centos:7

MAINTAINER SharxDC
COPY mariadb.repo /etc/yum.repos.d/mariadb.repo
COPY gosu /usr/local/bin/gosu

RUN yum -y install --setopt=tsflags=nodocs epel-release \
    tzdata && \ 
    useradd -u 9869 mysql && \
    yum -y install --setopt=tsflags=nodocs MariaDB-server tzdata && \   
    yum -y update && \
    yum clean all

RUN /bin/chmod +x /usr/local/bin/gosu && \
    mkdir -p /docker-entrypoint-initdb.d /var/run/mysqld /mnt/mariadb /mnt/log && \
    rm -rf /var/lib/mysql /var/log/mariadb && \
    chown -R mysql:mysql /mnt/mariadb /mnt/log /var/run/mysqld && \
    chmod 777 /var/run/mysqld && \
    ln -s /mnt/mariadb /var/lib/mysql && \
    ln -s /mnt/log /var/log/mariadb && \
    rm -rf /mnt/log /mnt/mariadb && \
    echo -e '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/my.cnf.d/docker.cnf

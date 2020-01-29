FROM centos:7

MAINTAINER SharxDC
COPY mariadb.repo /etc/yum.repos.d/mariadb.repo
COPY gosu /usr/local/bin/gosu
COPY entrypoint_new.sh /entrypoint.sh

RUN yum -y install --setopt=tsflags=nodocs epel-release && \ 
    useradd -u 9869 mysql && \
    yum -y install --setopt=tsflags=nodocs MariaDB-server && \   
    yum -y update && \
    yum clean all

RUN /bin/chmod +x /entrypoint.sh /usr/local/bin/gosu && \
    mkdir -p /var/log/mariadb  /docker-entrypoint-initdb.d && \
    rm -rf /var/lib/mysql && \
    mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld && \
    echo -e '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/my.cnf.d/docker.cnf

#ENTRYPOINT ["/entrypoint.sh"]

#USER 9869 

#EXPOSE 3306
#CMD ["mysqld"]

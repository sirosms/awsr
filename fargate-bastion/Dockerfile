FROM amazonlinux:2
RUN yum install -y sudo jq awscli shadow-utils htop lsof telnet bind-utils yum-utils && \
    yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm  \
    yum install -y yum localinstall https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm   && \
    yum-config-manager --disable mysql80-community && \
    yum-config-manager --enable mysql57-community && \
    rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022   && \
    yum install -y mysql-community-client && \
    yum install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm
COPY run.sh  /run.sh
ENTRYPOINT "/run.sh"
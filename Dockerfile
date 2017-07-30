FROM centos:7

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

RUN yum -y install yum-fastestmirror

RUN yum -y update && yum install -y sudo

# CentOSなどredhat系はwheel Debian系はsudo グループがsudoを許可されている
RUN groupadd -g 1000 dockuser && \
        useradd -g dockuser -G wheel -m -s /bin/bash docker && \
        echo 'docker:docker' | chpasswd

# sudo はpasswordなしで実行する
RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN curl https://install.meteor.com/ | sh

# ユーザーの指定
USER docker


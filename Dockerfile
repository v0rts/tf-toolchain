FROM centos:centos8
MAINTAINER The CentOS Project <cloud-ops@centos.org>

ENV TERRAFORM_VER  0.14.0-beta2
ENV AWSCLI_VER     2.0.61



RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install git; yum clean all
RUN yum -y install python2; yum clean all
RUN yum -y install python2-pip; yum clean all
RUN yum -y install wget; yum clean all
RUN yum -y install unzip; yum clean all

RUN set -x \
    && pip2 install --upgrade pip \
    && pip2 install --upgrade setuptools \
    && mkdir -p /usr/local/bin \
    && mkdir -p /tmp/installWork \
    && cd /tmp/installWork \
    && wget -k "https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_386.zip" \
    && unzip terraform_${TERRAFORM_VER}_linux_386.zip \
    && mv ./terraform /usr/local/bin \
    && wget -k "https://github.com/aws/aws-cli/archive/${AWSCLI_VER}.tar.gz" \
    && tar -xzf ${AWSCLI_VER}.tar.gz \
    && ls -al \
    && cd aws-cli-${AWSCLI_VER} \
    && python2 setup.py build \
    && python2 setup.py install \
    && ln -s /bin/aws /usr/local/bin/aws \
    && /usr/local/bin/aws --version \
    && python2 --version \
    && /usr/local/bin/terraform --version

#
# https://github.com/psi-4ward/psitransfer
#
FROM centos/nodejs-8-centos7:latest

MAINTAINER Andrei Stepanov <astepano@redhat.com>

EXPOSE 3000

HEALTHCHECK CMD wget -O /dev/null -q http://localhost:3000

ENV PSITRANSFER_UPLOAD_DIR="/data" \
    NODE_ENV="production"

LABEL io.k8s.description="PsiTransfer, simple open source self-hosted file sharing solution." \
      io.k8s.display-name="PsiTransfer" \
      io.openshift.tags="psitransfer" \
      io.openshift.expose-services="3000:http"

# Labels consumed by RedHat build service
LABEL com.redhat.component="psitransfer-docker" \
      name="PsiTransfer" \
      version="SS (SuperStable)" \
      architecture="x86_64" \
      summary="Containerized version of PsiTransfer" \
      release="devel"

# Set root to install necessary packages.
USER root

RUN PKGS="git \
          wget " && \
    yum install -y yum-utils && \
    yum install -y epel-release  --nogpgcheck && \
    yum install -y --setopt=tsflags=nodocs $PKGS && \
    yum clean all

COPY ./build /tmp/build
WORKDIR /tmp/build
RUN /tmp/build/build

VOLUME $PSITRANSFER_UPLOAD_DIR

# This container supposed to be unprivileged.
USER 1001

# $HOME is defined before in base image.
# docker inspect centos/nodejs-8-centos7:latest
WORKDIR $HOME
CMD ["sh", "-c", "exec $HOME/run"]

# This file describes the standard way to build Docker, using docker
#
# Usage:
#
# # Assemble the full dev environment. This is slow the first time.
# docker build -t docker .
#
# # Mount your source in an interactive container for quick testing:
# docker run -v `pwd`:/go/src/github.com/dotcloud/docker -privileged -i -t docker bash
#
# # Run the test suite:
# docker run -privileged docker hack/make.sh test
#
# # Publish a release:
# docker run -privileged \
#  -e AWS_S3_BUCKET=baz \
#  -e AWS_ACCESS_KEY=foo \
#  -e AWS_SECRET_KEY=bar \
#  -e GPG_PASSPHRASE=gloubiboulga \
#  docker hack/release.sh
#
# Note: Apparmor used to mess with privileged mode, but this is no longer
# the case. Therefore, you don't have to disable it anymore.
#

FROM	stackbrew/ubuntu:12.04
MAINTAINER	Vinay Malkani <vinay.malkani@stem.com> (@VinayMalkani)

# Add precise-backports to get s3cmd >= 1.1.0 (so we get ENV variable support in our .s3cfg)
RUN	echo 'deb http://archive.ubuntu.com/ubuntu precise-backports main universe' > /etc/apt/sources.list.d/backports.list

# Packaged dependencies
RUN	apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \ 
  python-software-properties \ 
  python \
  g++ \
  make

# Install nodejs
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN	apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \ 
  nodejs

#install express
RUN mkdir /stem
RUN cd /stem && npm install -g express

#install hello-world
RUN cd /stem && express hello-world
RUN cd /stem/hello-world && npm install hello world

#run hello world
WORKDIR /stem/hello-world
CMD["node app"]


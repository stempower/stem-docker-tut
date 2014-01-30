
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
RUN cd /stem/hello-world && npm install express
RUN cd /stem/hello-world && npm install jade
#run hello world

EXPOSE 3000
CMD ["node", "app.js"]

WORKDIR /stem/hello-world

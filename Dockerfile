FROM ubuntu:16.04

MAINTAINER Shinya Kumagai "roomful.rooms@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Install Java8
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update
RUN apt-get install -y oracle-java8-installer
RUN apt-get clean
RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
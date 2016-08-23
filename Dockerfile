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

# Clean Up apt-get
RUN apt-get clean
RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Android SDK
RUN cd /opt
RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN tar -xvzf android-sdk_r24.4.1-linux.tgz
RUN mv android-sdk-linux android-sdk
RUN rm android-sdk_r24.4.1-linux.tgz

ENV ANDROID_COMPONENTS platform-tools,android-23,android-24,build-tools-23.0.3,build-tools-24.0.1
ENV GOOGLE_COMPONENTS extra-android-m2repository,extra-google-m2repository

RUN echo y | /opt/android-sdk/tools/android update sdk --filter "${ANDROID_COMPONENTS}" --no-ui -a
RUN echo y | /opt/android-sdk/tools/android update sdk --filter "${GOOGLE_COMPONENTS}" --no-ui -a

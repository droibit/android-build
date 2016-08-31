# Base on: https://github.com/uber-common/android-build-environment
FROM ubuntu:14.04

MAINTAINER Shinya Kumagai "roomful.rooms@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Install Java8
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get update
RUN apt-get install -y oracle-java8-installer

# Install curl
RUN apt-get install -y curl

# Install dependencies
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -yq \
  libc6-i386 \
  lib32stdc++6 \
  lib32z1 \
  --no-install-recommends

# Clean Up apt-get
RUN apt-get clean
RUN rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Android SDK
RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN tar -xvzf android-sdk_r24.4.1-linux.tgz
RUN mv android-sdk-linux /opt/android-sdk
RUN rm android-sdk_r24.4.1-linux.tgz
RUN chown -R root.root /opt/android-sdk

ENV ANDROID_COMPONENTS platform-tools,build-tools-23.0.3,build-tools-24.0.1,android-23,android-24
ENV GOOGLE_COMPONENTS extra-android-m2repository,extra-google-m2repository

RUN echo y | /opt/android-sdk/tools/android update sdk --filter "${ANDROID_COMPONENTS}" --no-ui -a
RUN echo y | /opt/android-sdk/tools/android update sdk --filter "${GOOGLE_COMPONENTS}" --no-ui -a

# Environment variables
ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_SDK_HOME $ANDROID_HOME
ENV PATH $PATH:$ANDROID_SDK_HOME/tools
ENV PATH $PATH:$ANDROID_SDK_HOME/platform-tools
ENV PATH $PATH:$ANDROID_SDK_HOME/build-tools/23.0.3
ENV PATH $PATH:$ANDROID_SDK_HOME/build-tools/24.0.1

# Export JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Support Gradle
ENV TERM dumb
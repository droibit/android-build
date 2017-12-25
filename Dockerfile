# based on https://github.com/gfx/docker-android-project with openjdk-8
FROM openjdk:8

MAINTAINER Shinya Kumagai <roomful.rooms@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -yq libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 --no-install-recommends && \
    apt-get clean

# Download and untar SDK
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
RUN curl -L "${ANDROID_SDK_URL}" -o android-sdk-linux.zip
RUN unzip android-sdk-linux.zip -d /usr/local/android-sdk-linux
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_SDK /usr/local/android-sdk-linux
ENV PATH $ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

# Accepted Licenses
RUN mkdir "$ANDROID_HOME/licenses" || true
RUN echo "d56f5187479451eabf01fb78af6dfcb131a6481e" > "$ANDROID_HOME"/licenses/android-sdk-license

# Install Android SDK
RUN $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" \
    "build-tools;26.0.3" \
    "platforms;android-26"

# Support Gradle
ENV TERM dumb

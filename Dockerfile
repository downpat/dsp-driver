FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT=/opt/android-sdk

RUN apt-get update
RUN apt-get install -y openjdk-17-jdk
RUN apt-get install -y curl
RUN apt-get install -y unzip
RUN apt-get install -y usbutils
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools
WORKDIR /tmp

RUN curl -o sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-14742923_latest.zip
RUN unzip sdk.zip
RUN mv cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest
RUN rm sdk.zip

ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
ENV PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

RUN yes | sdkmanager --licenses

RUN sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

WORKDIR /workspace

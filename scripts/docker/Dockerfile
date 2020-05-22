FROM ubuntu:18.04
MAINTAINER Jonathan Underwood

RUN apt-get update -y && \
  apt-get upgrade -y

RUN apt-get install curl wget unzip git npm -y && \
  npm i n -g && \
  n stable && \
  echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && \
  sysctl -p

ARG JDK=1.8
ARG TARGET_JDK=$JDK
ARG TRAVIS_OS_NAME=linux
RUN useradd android && \
  mkdir /home/android && \
  chown android:android /home/android && \
  curl https://raw.githubusercontent.com/DanySK/Gravis-CI/master/.install-jdk-travis.sh --output /home/android/.install-jdk-travis.sh && \
  chown android:android /home/android/.install-jdk-travis.sh && \
  chmod +x /home/android/.install-jdk-travis.sh && \
  cd /home/android && \
  su android -c "/home/android/.install-jdk-travis.sh"

USER android
WORKDIR /home/android
ARG ABI=x86_64
ARG ADB_INSTALL_TIMEOUT=8
ARG COMPILE_API=29
ARG ANDROID_BUILD_TOOLS=29.0.2
ARG ANDROID_HOME=/home/android/android-sdk
ARG EMU_FLAVOR=default
ARG TOOLS=$ANDROID_HOME/tools
ARG API=28

RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O android-sdk-tools.zip && \
  unzip -q android-sdk-tools.zip -d $ANDROID_HOME && \
  rm android-sdk-tools.zip && \
  mkdir /home/android/.android && \
  echo 'count=0' > /home/android/.android/repositories.cfg

RUN export JAVA_HOME=/home/android/.jabba/jdk/$(ls /home/android/.jabba/jdk) && \
  yes | /home/android/android-sdk/tools/bin/sdkmanager --licenses >/dev/null && \
  echo y | /home/android/android-sdk/tools/bin/sdkmanager --no_https "platform-tools" >/dev/null && \
  echo y | /home/android/android-sdk/tools/bin/sdkmanager --no_https "tools" >/dev/null && \
  echo y | /home/android/android-sdk/tools/bin/sdkmanager --no_https "build-tools;$ANDROID_BUILD_TOOLS" >/dev/null && \
  echo y | /home/android/android-sdk/tools/bin/sdkmanager --no_https "platforms;android-$COMPILE_API" >/dev/null && \
  $JAVA_HOME/bin/keytool -genkeypair -v -keystore detox.keystore -alias detox -keyalg RSA -keysize 2048 -validity 10000 -storepass 123456 -keypass 123456 -dname 'cn=Unknown, ou=Unknown, o=Unknown, c=Unknown'

COPY ./startup.sh /home/android/
USER root
RUN mkdir /data && \
  chown android:android /data && \
  chmod +x /home/android/startup.sh && \
  chown android:android /home/android/startup.sh
USER android
ENTRYPOINT ["bash", "-c", "/home/android/startup.sh"]

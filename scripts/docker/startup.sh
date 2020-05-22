#!/usr/bin/env bash
export JAVA_HOME=/home/android/.jabba/jdk/$(ls /home/android/.jabba/jdk)
export ANDROID_SDK_ROOT=/home/android/android-sdk
git clone --branch v5.3.7 https://github.com/BlueWallet/BlueWallet
cd BlueWallet
npm i
cd android
./gradlew assembleRelease
$JAVA_HOME/bin/jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /home/android/detox.keystore ./app/build/outputs/apk/release/app-release-unsigned.apk  detox -storepass 123456
mv ./app/build/outputs/apk/release/app-release-unsigned.apk /data/app-release-unsigned.apk

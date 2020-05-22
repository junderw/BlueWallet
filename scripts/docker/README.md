# Building APK using Docker

## Build Docker Image

```bash
# First cd to the folder of this README
docker build . -t bluewalletbuilder
```

## Run Build Command

```bash
# First cd to the folder of this README
docker run --name builder -v $(pwd)/output:/data bluewalletbuilder
```

## Find the apk in the output folder

```bash
adb install ./output/app-release-unsigned.apk
```

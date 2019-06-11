FROM bengreenier/x11-electron:latest
WORKDIR /home/electron
ENV ELECTRON_VERSION=latest
ENV ELECTRON_ENTRY=./main.js
ENV ELECTRON_ENABLE_LOGGING=1

# assuming you have some electron code in dist
COPY ./main.js ./

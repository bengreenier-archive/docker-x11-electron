FROM debian:stable-slim
# Which electron version (npm semver) we use
ARG ELECTRON_VERSION=latest

# Which node version (major only 10, 11, 12, etc) we use
ARG NODE_VERSION=10

# Where our electron entrypoint is (relative to workdir)
ARG ELECTRON_ENTRY=.

# Get all the x+electron deps we need
RUN apt-get update
RUN apt-get install -y curl \
  dos2unix \
  xinit \
  libnss3 \
  libxss1 \
  libasound2 \
  libgdk-pixbuf2.0-0 \
  libgtk-3-0 \
  xserver-xorg-video-dummy \
  xserver-xorg-legacy \
  x11-xserver-utils \
  fonts-liberation \
  fonts-roboto \
  fonts-symbola

# Create a lower-priv user (electron) to run as
RUN groupadd -r electron && useradd -r -g electron -G audio,video,tty electron \
&& mkdir -p /home/electron/Downloads && chown -R electron:electron /home/electron

# Install node
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
RUN apt-get install -y nodejs

# Install electron
RUN npm install -g electron@${ELECTRON_VERSION} --unsafe-perm=true

# Grab our display config and startup script
WORKDIR /usr/bin/app
COPY .display.conf .x-cmd.sh ./
RUN dos2unix .display.conf .x-cmd.sh
RUN chmod +x .x-cmd.sh

# Execute startup script (note: we run as root, and drop into lower-priv user inside the script)
# We need to do this as X must be started as root
CMD /usr/bin/app/.x-cmd.sh ${ELECTRON_ENTRY}

# X11-Electron

[![Build Status](https://b3ngr33ni3r.visualstudio.com/x11-electron/_apis/build/status/bengreenier.docker-x11-electron?branchName=master)](https://b3ngr33ni3r.visualstudio.com/x11-electron/_build/latest?definitionId=7&branchName=master)

Starts x11 and runs electron all-inclusive inside a container. Uses [xdummy](https://xpra.org/trac/wiki/Xdummy) for rendering.

Supports the following [arguments](https://docs.docker.com/engine/reference/builder/#arg):

+ ELECTRON_VERSION=`latest`: Which electron version (npm semver) we use
+ NODE_VERSION=`10`: Which node version (major only 10, 11, 12, etc) we use
+ ELECTRON_ENTRY=`.`: Where our electron entrypoint is (relative to workdir)

You'll probably want to derive from this container:

```
FROM bengreenier/x11-electron
ENV ELECTRON_VERSION=5.0.0
ENV ELECTRON_ENTRY=./dist/main.js

# assuming you have some electron code in dist
COPY ./dist ./
```

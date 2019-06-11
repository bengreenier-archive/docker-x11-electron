ELECTRON_ENTRY_POINT=$1

if [ -z "$ELECTRON_ENTRY_POINT" ]
  then
    echo "No electron entrypoint supplied"
fi

# Start x
Xorg -nocursor -noreset +extension GLX +extension RANDR +extension RENDER -config /usr/bin/app/.display.conf :10 &
export DISPLAY=:10

# Verify x goes up safely
X_WAIT_MAX=40
X_WAIT_COUNT=0
while ! xdpyinfo >/dev/null 2>&1; do
  sleep .3
  X_WAIT_COUNT=$(( X_WAIT_COUNT + 1 ))
    if [ "$X_WAIT_COUNT" -ge "$X_WAIT_MAX" ]; then
      echo "Gave up waiting for X"
      exit 11
    fi
done

# Run electron as the electron user
su - electron -c "electron --no-sandbox $ELECTRON_ENTRY_POINT"

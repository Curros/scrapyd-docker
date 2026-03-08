#!/bin/sh
set -e

PUID=${PUID:-99}
PGID=${PGID:-100}

APP_DIR=/app

# List of files to ignore, separated by |
IGNORE_FILES="twistd.pid"

echo "[entrypoint] Fixing permissions..."
chown -R $PUID:$PGID "$APP_DIR"

echo "[entrypoint] Checking for missing files from image..."
# loop over all files in image /app-image
find /app-image -type f | while read filepath; do
    relpath="${filepath#/app-image/}"
    target="$APP_DIR/$relpath"

    # IGNORE specific files
    case "$relpath" in 
        $IGNORE_FILES )
            echo "Skipping $relpath"
            continue
            ;;
    esac

    if [ ! -f "$target" ]; then
        echo "Copying missing file: $relpath"
        mkdir -p "$(dirname "$target")"
        cp "$filepath" "$target"
        chown $PUID:$PGID "$target"
    fi
done

echo "[entrypoint] Starting Scrapyd..."
exec scrapyd -n
set -euo pipefail

# Create dir in Pictures to store wallpapers
WALLPAPERS_DIR="$HOME/Pictures/bing-wallpapers"
mkdir -p $WALLPAPERS_DIR

# Extract photo URL from bing's homepage
BING_DOMAIN="https://bing.com"
BING_PHOTO_RELATIVE_PATH=$(echo "$(curl -sL $BING_DOMAIN/ | grep -Eo 'th\?id=.*?tmb.jpg')" | sed -e "s/tmb/UHD/")
BING_PHOTO_URL="$BING_DOMAIN/$BING_PHOTO_RELATIVE_PATH"
BING_PHOTO_FILENAME=${BING_PHOTO_RELATIVE_PATH/th\?id=/}

# Download daily bing image
LOCAL_PHOTO_PATH="$WALLPAPERS_DIR/$BING_PHOTO_FILENAME"
if [ -f $LOCAL_PHOTO_PATH ]; then
    echo "Photo ${BING_PHOTO_FILENAME} already downloaded. Skipping download"
else
    echo "Downloading $BING_PHOTO_URL"
    curl -Lo "$LOCAL_PHOTO_PATH" "$BING_PHOTO_URL"
fi

# Double check that image is here
if [ ! -f $LOCAL_PHOTO_PATH ]; then
    echo "No photo at $LOCAL_PHOTO_PATH. Something went wrong... Exiting"
    exit 1
fi

osascript -e 'tell application "System Events" to set picture of every desktop to "'$LOCAL_PHOTO_PATH'"'
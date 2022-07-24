set -euo pipefail

# Create dir in Pictures to store wallpapers
WALLPAPERS_DIR="$HOME/Pictures/bing-wallpapers"
mkdir -p $WALLPAPERS_DIR

# Move into current directory
cd "$(dirname "$(readlink -f "$0")")"

# Get screen info to pass on to script
SCREEN_INFO=$(system_profiler SPDisplaysDataType | awk '/Resolution/{print $2, $3, $4}')
SCREEN_INFO_ARR=(${SCREEN_INFO//\ x\ / })
SCREEN_WIDTH=${SCREEN_INFO_ARR[0]}
SCREEN_HEIGHT=${SCREEN_INFO_ARR[1]}
# The lines below seem to give different values
# SCREEN_INFO=$(osascript -e 'tell application "Finder" to get bounds of window of desktop')
# SCREEN_INFO_ARR=(${SCREEN_INFO//,/ })
# SCREEN_WIDTH=${SCREEN_INFO_ARR[2]}
# SCREEN_HEIGHT=${SCREEN_INFO_ARR[3]}

# # Run node script to create wallpaper image from Bing
. ~/.nvm/nvm.sh
nvm install && nvm use && npm install
npm run build
LOCAL_PHOTO_PATH=$(node dist/index.js $WALLPAPERS_DIR $SCREEN_WIDTH $SCREEN_HEIGHT)

# Double check that image is here
if [ ! -f $LOCAL_PHOTO_PATH ]; then
    echo "No photo at $LOCAL_PHOTO_PATH. Something went wrong... Exiting"
    exit 1
fi

# Set the desktop image
osascript -e 'tell application "System Events" to set picture of every desktop to "'$LOCAL_PHOTO_PATH'"'
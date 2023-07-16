# https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM ERR
trap "kill 0" EXIT

echo "Running dev.sh"

# Create dir in Pictures to store wallpapers
WALLPAPERS_DIR="$HOME/Pictures/bing-wallpapers"
mkdir -p $WALLPAPERS_DIR

# Get screen info to pass on to script
SCREEN_INFO=$(system_profiler SPDisplaysDataType | awk '/Resolution/{print $2, $3, $4}')
SCREEN_INFO_ARR=(${SCREEN_INFO//\ x\ / })
SCREEN_WIDTH=${SCREEN_INFO_ARR[0]}
SCREEN_HEIGHT=${SCREEN_INFO_ARR[1]}

echo "Starting tsc and nodemon in the background"
. ~/.nvm/nvm.sh --no-use
nvm install && nvm use
npx tsc --watch &
npx nodemon --inspect ./dist/index.js -- $WALLPAPERS_DIR $SCREEN_WIDTH $SCREEN_HEIGHT &

echo "...Waiting for background scripts to end"
wait
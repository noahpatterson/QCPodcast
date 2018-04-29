#!/bin/bash
# to install eyeD3 - sudo pip install eyeD3

# Arguments Name of mp3, Episode number-the actual number, title of episode, episode part number

# name of the file
FILE=QC.Podcast.Episode.$4.mp3
# directory the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Applying name and format to: $1, for episode $4, with title $3"
cp "$1" $FILE
echo "Removing all tags"
eyeD3 --remove-all $FILE
echo "Applying tags"
eyeD3 --artist="Kate Drake and Jessica Williamson" --album="QCPodcast - A Questionable Content Podcast" --track=$2 \
      --genre="Podcast" --recording-date=`date +"%Y"` --title="$3" \
      --url-frame="WPUB:https\://www.qc-podcast.com" \
      --url-frame="WCOP:http\://creativecommons.org/licenses/by/3.0/" \
      --add-image="$DIR/album.png":FRONT_COVER \
      $FILE

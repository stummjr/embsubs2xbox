#!/bin/bash

while [[ $# > 1 ]]
do
    key="$1"
    shift
    case $key in
        -i|--input)
            INPUT="$1"
            shift
        ;;
        -o|--output)
            OUTPUT="$1"
            shift
        ;;
        -l|--lang)
            LANGUAGE="$1"
            shift
        ;;
        -s|--subtitles)
            SUBTITLES="$1"
            shift
        ;;
        *)
            echo "Error: option $1 not available."
            exit 1
        ;;
    esac
done

DIRNAME=$(dirname "$INPUT")
COMPLETE_FILENAME=$(basename "$INPUT")
EXTENSION="${COMPLETE_FILENAME##*.}"
FILENAME="${COMPLETE_FILENAME%.*}"
if [[ -z $OUTPUT ]];
then
    OUTPUT="subtitled.$COMPLETE_FILENAME"
fi


if [[ -z $SUBTITLES ]];
then
    type subliminal >/dev/null 2>&1 || { 
        echo >&2 "Error: subliminal is required."; exit 1; 
    }

    echo "Downloading subtitle in $LANGUAGE for $COMPLETE_FILENAME..."
    subliminal -s -l $LANGUAGE -- "$COMPLETE_FILENAME" &> /dev/null
    if [ $? -ne 0 ]; then
        echo "subliminal failed to download subtitles for $FILENAME in $LANGUAGE."
        exit 1
    fi
    SUBTITLES="$FILENAME.srt"
fi

type mencoder >/dev/null 2>&1 || { 
    echo >&2 "Error: mencoder is required."; exit 1; 
}
echo "Starting encoding of $COMPLETE_FILENAME"
mencoder -sub "$SUBTITLES" -utf8 -ovc xvid -xvidencopts bitrate=-700000 -oac mp3lame -o "$DIRNAME/$OUTPUT" "$INPUT" &> /dev/null
echo "Finished encoding of $COMPLETE_FILENAME"

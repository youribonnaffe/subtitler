#!/bin/sh

function extractNameFromSrtFile {
    name=$(echo $* | cut -f1 -d " " | tr "[:upper:]" "[:lower:]" | sed "s/[^A-Za-z]*//g")
}

function extractSeasonFromSrtFile {
    season=$(echo $* | egrep  -o "[[:digit:]]{1,}" | head -n1)
}

function extractEpisodeFromSrtFile {
    episode=$(echo $* | egrep  -o "[[:digit:]]{1,}" | head -n2 | tail -n1)
}

function isMovieMatchingNameSeasonEpisode {
    if $(echo $1 | grep -q -i "$2") 
        then
            if $(echo $1 | grep -q -i "$3")
                then
                    if $(echo $1 | grep -q -i "$4")
                        then echo match $srtFile >> ~/subtitle.log
                            return 0
                    fi
            fi
    fi
    return 1   
}

OLD_IFS=$IFS
IFS=$'\n'

# MAIN

movieFile=$*
folder=$(dirname $movieFile)
echo $movieFile >> ~/subtitle.log
for srtFile in $(find $folder -maxdepth 1 -name "*.srt")
do
    IFS=$OLD_IFS
    
    extractNameFromSrtFile $(basename $srtFile)
    extractSeasonFromSrtFile $(basename $srtFile)
    extractEpisodeFromSrtFile $(basename $srtFile)
    
    echo $movieFile $srtFile >> ~/subtitle.log
    echo $name $season $episode >> ~/subtitle.log
    
    if isMovieMatchingNameSeasonEpisode $movieFile $name $season $episode
        then
            newSrtFile=$(echo $movieFile | sed "s/.avi/.srt/")
            mv "$srtFile" "$newSrtFile"
    fi
done
#!/bin/sh
  
#setUp
srtBefore=$(echo *.srt)
cd folder
#test

../../Subtitler.app/subtitle.sh "*.avi"

expectedSrtFile=$(echo *.avi| sed "s/.avi/.srt/")
test -f "$expectedSrtFile"
result=$?

#tearDown
cd ..
mv folder/*.srt "$srtBefore"

return $result
#!/bin/sh
  
#setUp
srtBefore=$(echo *.srt)

#test
../Subtitler.app/subtitle.sh "*.mkv"

expectedSrtFile=$(echo *.mkv| sed "s/.mkv/.srt/")
test -f "$expectedSrtFile"
result=$?

#tearDown

mv *.srt "$srtBefore"

return $result
#!/bin/sh
  
#setUp
srtBefore=$(echo *.srt)

#test
../subtitle.sh "*.avi"

expectedSrtFile=$(echo *.avi| sed "s/.avi/.srt/")
test -f "$expectedSrtFile"
result=$?

#tearDown

mv *.srt "$srtBefore"

return $result
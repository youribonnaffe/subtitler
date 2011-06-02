#!/bin/sh


function runTest {
    cd $1
    source ./test.sh
    result=$?
    cd ..
    if [ "$result" -eq "0" ]
        then echo  "\033[01;32mPASSED\033[0m"
        else echo "\033[01;31mFAILED\033[0m"
    fi
}


runTest test_simple
runTest test_mkv
runTest test_movie_in_folder
runTest test_srt_in_folder
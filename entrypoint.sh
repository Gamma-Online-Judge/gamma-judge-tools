#!/bin/bash
while :
do
	tput sgr0    
    echo "Processing message"
    result=$(./process_message.sh)
    result_code=$?
    if [ $result_code -eq 0 ]; then
        tput setaf 2
        echo "Message processed successfully"
        echo "Result is $result"
        tput sgr0
    elif [ $result_code -eq 2 ]; then
        echo "No messages to process - sleeping"
        sleep 2
    else
        tput setaf 1
        echo "Error while processing message"
        echo "Result is $result"
        tput sgr0
    fi
done
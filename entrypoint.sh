#!/bin/bash
while :
do
	echo "Syncronizing with S3"
    ./sync.sh
    echo "Searching for messages"
    result=$(./process_message.sh)
    result_code=$?
    if [ $result_code -eq 0 ]; then
        echo "Message processed successfully"
        echo "Result is $result"
    elif [ $result_code -eq 2 ]; then
        echo "No messages to process - sleeping"
        sleep 10
    else
        echo "Message not processed"
        echo "Result is $result"
    fi
done
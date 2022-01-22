QUEUE_URL="https://sqs.sa-east-1.amazonaws.com/818598312538/SubmissionsQueue"
MAX_MESSAGES=1

response=$(aws sqs receive-message --queue-url $QUEUE_URL --max-number-of-messages $MAX_MESSAGES)
raw_message=$(echo $response | jq -r '.Messages[0]')
if [ -z "$raw_message" ]; then
    exit 2
fi

message=$(echo $raw_message | jq -r '.Body')
id=$(echo $message | jq -r '.Id')
file_key=$(echo $message | jq -r '.FileKey')
problem_id=$(echo $message | jq -r '.ProblemId')
language=$(echo $message | jq -r '.Language')

./send_sns_notification.sh $id "Running" > /dev/null

## Sync s3 file
./sync.sh > /dev/null
file_path=s3-bucket/submission_files/$file_key
if [ ! -f "$file_path" ]; then
    aws s3 cp s3://gama-judge-submissions/submission_files/$file_key $file_path
fi

result=$(./judge.sh $file_key $language $problem_id)
result_code=$?
echo $result
if [ $result_code -eq 0 ]; then
    rm $file_path
    ./send_sns_notification.sh $id $result > /dev/null
    aws sqs delete-message --queue-url $QUEUE_URL --receipt-handle $(echo $raw_message | jq -r '.ReceiptHandle') > /dev/null
    exit 0
else
    ./send_sns_notification.sh $id "InQueue" > /dev/null
    echo $result
    echo "Result code is $result_code"
    exit 1
fi
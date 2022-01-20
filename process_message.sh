QUEUE_URL=https://sqs.sa-east-1.amazonaws.com/818598312538/SubmissionsQueue
MAX_MESSAGES=1

response=$(aws sqs receive-message --queue-url $QUEUE_URL --max-number-of-messages $MAX_MESSAGES)
raw_message=$(echo $response | jq -r '.Messages[0]')
if [ -z "$raw_message" ]; then
    echo "No messages"
    exit 0
fi

message=$(echo $raw_message | jq -r '.Body')
file_key=$(echo $message | jq -r '.FileKey')
problem_id=$(echo $message | jq -r '.ProblemId')
language=$(echo $message | jq -r '.Language')

echo "Processing file $file_key"
result=$(./judge.sh $file_key $language $problem_id)
if [ $? -eq 0 ]; then
    echo "OK"
    aws sqs delete-message --queue-url $QUEUE_URL --receipt-handle $(echo $raw_message | jq -r '.ReceiptHandle')
else
    echo "FAIL - $result"
fi
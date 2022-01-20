QUEUE_URL=https://sqs.sa-east-1.amazonaws.com/818598312538/SubmissionsQueue
MAX_MESSAGES=1

response=$(aws sqs receive-message --queue-url $QUEUE_URL --max-number-of-messages $MAX_MESSAGES)
raw_message=$(echo $response | jq -r '.Messages[0]')
if [ -z "$raw_message" ]; then
    exit 2
fi

message=$(echo $raw_message | jq -r '.Body')
file_key=$(echo $message | jq -r '.FileKey')
problem_id=$(echo $message | jq -r '.ProblemId')
language=$(echo $message | jq -r '.Language')

result=$(./judge.sh $file_key $language $problem_id)
echo $result

if [ $? -eq 0 ]; then
    aws sqs delete-message --queue-url $QUEUE_URL --receipt-handle $(echo $raw_message | jq -r '.ReceiptHandle')
    exit 0
else
    exit 1
fi
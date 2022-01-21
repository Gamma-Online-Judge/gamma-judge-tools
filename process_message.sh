QUEUE_URL="https://sqs.sa-east-1.amazonaws.com/818598312538/SubmissionsQueue"
TOPIC_ARN="arn:aws:sns:sa-east-1:818598312538:SubmissionResult"
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

result=$(./judge.sh $file_key $language $problem_id)
result_code=$?
echo $result
if [ $result_code -eq 0 ]; then
    notification_message=$(jo -p Id=$id Result="$result")
    aws sns publish --topic-arn "$TOPIC_ARN" --message "$notification_message" > /dev/null
    aws sqs delete-message --queue-url $QUEUE_URL --receipt-handle $(echo $raw_message | jq -r '.ReceiptHandle') > /dev/null
    exit 0
else
    echo $result
    echo "Result code is $result_code"
    exit 1
fi
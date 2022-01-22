TOPIC_ARN="arn:aws:sns:sa-east-1:818598312538:SubmissionResult"
submission_id=$1
status=$2
if [ -z "$submission_id" -z "$status" ]; then
    echo "Usage: $0 <submission_id> <status>"
    exit 1
fi
notification_message=$(jo -p Id=$submission_id Result="$status")
aws sns publish --topic-arn "$TOPIC_ARN" --message "$notification_message" > /dev/null
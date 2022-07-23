TOPIC_ARN="arn:aws:sns:sa-east-1:459427504023:SubmissionResult"
submission_id=$1
status=$2
if [ -z "$submission_id" ] || [ -z "$status" ]; then
    echo "Usage: send_sns_notification.sh <submission_id> <status>"
    exit 1
fi
notification_message=$(jo -p Id=$submission_id Result="$status")
aws sns publish --topic-arn "$TOPIC_ARN" --message "$notification_message" > /dev/null
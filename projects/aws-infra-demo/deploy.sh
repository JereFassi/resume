#!/usr/bin/env bash
set -euo pipefail

# Optional: override the env file path via ENV_FILE=.env.dev ./deploy.sh
ENV_FILE="${ENV_FILE:-.env}"

# Load environment variables from the env file if present (ignores comments)
if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC2046
  export $(grep -v '^#' "$ENV_FILE" | xargs)
fi

# Required variables
: "${PACKAGING_BUCKET:?Set PACKAGING_BUCKET (S3 bucket for nested templates)}"
: "${STACK_NAME:?Set STACK_NAME (CloudFormation stack name)}"
: "${PROJECT_NAME:?Set PROJECT_NAME (e.g., aws-infra-demo)}"
: "${ENVIRONMENT:?Set ENVIRONMENT (dev/test/prod)}"
: "${EC2_KEY_PAIR_NAME:?Set EC2_KEY_PAIR_NAME (existing key pair)}"
: "${DB_PASSWORD:?Set DB_PASSWORD (strong password)}"

# Optional overrides
AWS_PROFILE="${AWS_PROFILE:-}"
AWS_REGION="${AWS_REGION:-}"
TEMPLATE_FILE="${TEMPLATE_FILE:-templates/main.yaml}"
PACKAGED_TEMPLATE="${PACKAGED_TEMPLATE:-/tmp/packaged-main.yaml}"

aws_cli() {
  AWS_PROFILE="$AWS_PROFILE" AWS_REGION="$AWS_REGION" aws "$@"
}

echo "Packaging templates to S3 bucket: $PACKAGING_BUCKET"
aws_cli cloudformation package \
  --template-file "$TEMPLATE_FILE" \
  --s3-bucket "$PACKAGING_BUCKET" \
  --output-template-file "$PACKAGED_TEMPLATE"

echo "Deploying stack: $STACK_NAME"
aws_cli cloudformation deploy \
  --template-file "$PACKAGED_TEMPLATE" \
  --stack-name "$STACK_NAME" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    ProjectName="$PROJECT_NAME" \
    Environment="$ENVIRONMENT" \
    EC2KeyPairName="$EC2_KEY_PAIR_NAME" \
    DBPassword="$DB_PASSWORD" \
  --no-fail-on-empty-changeset

echo "Deployment complete."

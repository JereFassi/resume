# AWS Infra Demo (CloudFormation)

CloudFormation sample that stands up a minimal VPC with an EC2 web server, PostgreSQL RDS instance, and a private S3 bucket. A companion pipeline template shows how to deploy the stack with CodeCommit + CodeBuild + CodePipeline.

## What's here

- `templates/main.yaml` – Entry point that nests the networking, IAM, EC2, and RDS templates.
- `templates/networking.yaml` – VPC (1 public, 2 private subnets), routing, and security groups.
- `templates/iam.yaml` – EC2 role and instance profile.
- `templates/ec2.yaml` – App bucket and EC2 web server.
- `templates/rds.yaml` – PostgreSQL RDS instance and subnet group.
- `templates/pipeline.yaml` – Pipeline that pulls from CodeCommit, runs CodeBuild validation, and deploys the infra stack via CloudFormation.
- `buildspec.yml` – Build recipe used by CodeBuild to package/validate the templates and pass them to the deploy stage.
- `deploy.sh` – Local helper script to package nested stacks and deploy via CloudFormation using values from `.env`.
- `.env.example` – Example environment file consumed by `deploy.sh`.

## Quick architecture notes

- EC2 in a public subnet with SSH (`SSHLocation` parameter) and HTTP open; instance profile includes SSM + S3 read-only so you can reach it without exposing more ports.
- RDS lives in private subnets and only accepts traffic from the EC2 security group.
- S3 buckets (app + pipeline artifacts) are private, versioned, and SSE-S3 encrypted.
- CloudFormation deploy action runs with a dedicated execution role; pipeline uses `CAPABILITY_NAMED_IAM` because the infra stack creates IAM resources.

## Prerequisites

- AWS CLI configured with credentials and default region.
- An existing EC2 key pair name for SSH access (`EC2KeyPairName` parameter).
- A CodeCommit repository name (existing) for the pipeline template.

### Deploy via script (recommended for local use)

1. Copy the example env and edit values:

```bash
cp .env.example .env
```

2. Run the helper script (uses your configured AWS CLI profile/region):

```bash
chmod +x deploy.sh
./deploy.sh
```

## Deploy the infra stack directly (optional)

If you just want the EC2/RDS/S3 stack without the pipeline (requires an S3 bucket for nested stack packaging):

```bash
aws cloudformation package \
  --template-file templates/main.yaml \
  --s3-bucket <packaging-bucket> \
  --output-template-file templates/packaged-main.yaml

aws cloudformation deploy \
  --template-file templates/packaged-main.yaml \
  --stack-name aws-infra-demo \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    ProjectName=aws-infra-demo \
    Environment=dev \
    EC2KeyPairName=<your-keypair> \
    DBPassword=<secure-password>
```

Outputs include the EC2 public DNS, RDS endpoint, and S3 bucket name.

## Set up the CI/CD pipeline

1. Create (or reuse) a CodeCommit repo and push this folder's contents to it:

```bash
aws codecommit create-repository --repository-name aws-infra-demo
# Clone/push your repo as usual, ensuring templates/ and buildspec.yml are committed.
```

2. Deploy the pipeline stack (pass your repo name and DB password the infra stack should use):

```bash
aws cloudformation deploy \
  --template-file templates/pipeline.yaml \
  --stack-name aws-infra-demo-pipeline \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    ProjectName=aws-infra-demo \
    Environment=dev \
    CodeCommitRepositoryName=aws-infra-demo \
    CloudFormationStackName=aws-infra-demo \
    DBPassword=<secure-password>
```

3. Commit/push changes to the tracked branch (`main` by default) to trigger the pipeline. The deploy stage applies `templates/packaged-main.yaml` to the target stack.

Note: The buildspec expects `PACKAGING_BUCKET` to be set (the pipeline injects the artifact bucket automatically) so nested stacks can be packaged before deployment.

## Clean up

- Delete the pipeline stack first (`aws cloudformation delete-stack --stack-name aws-infra-demo-pipeline`).
- Empty then delete the pipeline artifact bucket and app bucket if stack deletion fails due to non-empty buckets.
- Delete the infra stack (`aws cloudformation delete-stack --stack-name aws-infra-demo`).

## Notes and cautions

- This is a learning/demo setup; RDS backups are disabled and IAM policies are broad for simplicity. Tighten IAM + networking before production use.
- Restrict `SSHLocation` to your IP instead of `0.0.0.0/0`.

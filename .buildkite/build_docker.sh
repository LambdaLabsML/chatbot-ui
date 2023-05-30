#!/bin/bash

set -euo pipefail

REGION="us-west-2"
REGISTRY="921575574570.dkr.ecr.us-west-2.amazonaws.com"
PROJECT="chatbot-ui"
BRANCH_CLEAN=${BUILDKITE_BRANCH/\//_}

docker build -t "$REGISTRY/$PROJECT:${BRANCH_CLEAN}" .

aws ecr get-login-password --region "$REGION" | docker login --username AWS --password-stdin "$REGISTRY"

docker push "$REGISTRY/$PROJECT:${BRANCH_CLEAN}"

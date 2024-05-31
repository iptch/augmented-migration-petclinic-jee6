#!/bin/bash

# Set the necessary variables
AWS_REGION="eu-central-1"
ECR_REPOSITORY_URI="992382757569.dkr.ecr.eu-central-1.amazonaws.com"
IMAGE_NAME="petclinic-vfunction"
IMAGE_TAG="latest"

# Authenticate Docker client with Amazon ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPOSITORY_URI

# Build the Docker image
docker build -t $ECR_REPOSITORY_URI/$IMAGE_NAME/test:$IMAGE_TAG .

# Push the Docker image to Amazon ECR
docker push $ECR_REPOSITORY_URI/$IMAGE_NAME:$IMAGE_TAG
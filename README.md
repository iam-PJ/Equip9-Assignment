# HTTP Service to List S3 Bucket Contents with Terraform Deployment

This project demonstrates how to create an HTTP service using Python and Flask, which lists the contents of an AWS S3 bucket. Additionally, it provisions the necessary infrastructure and deploys the service on an EC2 instance using Terraform.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Prerequisites](#prerequisites)
3. [Part 1: HTTP Service](#part-1-http-service)
    - [Setting Up the Environment](#setting-up-the-environment)
    - [Writing the Application](#writing-the-application)
    - [Running the Application](#running-the-application)
    - [Testing the API](#testing-the-api)
4. [Part 2: Terraform Deployment](#part-2-terraform-deployment)
    - [Installing Terraform](#installing-terraform)
    - [Configuring Terraform Project](#configuring-terraform-project)
    - [Deploying the Infrastructure](#deploying-the-infrastructure)
    - [Testing the Deployment](#testing-the-deployment)
5. [Securing the Service with HTTPS](#securing-the-service-with-https)
6. [Clean Up](#clean-up)
7. [Deliverables](#deliverables)
8. [Conclusion](#conclusion)

## Project Overview

This project involves two main parts:

1. **HTTP Service**: A Python-based HTTP service that interacts with an AWS S3 bucket using the `boto3` SDK to list its contents. The service is built with Flask and exposes a REST API endpoint to fetch the S3 bucket content.

2. **Terraform Deployment**: Provisioning the necessary AWS infrastructure using Terraform and deploying the HTTP service on an EC2 instance.

## Prerequisites

- An AWS account.
- Terraform installed on your local machine.
- Access to an EC2 instance (or use Terraform to provision one).
- Basic knowledge of Python, Flask, and Terraform.

## Part 1: HTTP Service

### Setting Up the Environment

1. **Log into the EC2 instance**:
   - SSH into your AWS EC2 instance where you will host the service.

2. **Install Python 3 and pip**:
   ```bash
   sudo yum install python3 -y
   sudo yum install python3-pip -y
   python3 --version
   pip3 --version

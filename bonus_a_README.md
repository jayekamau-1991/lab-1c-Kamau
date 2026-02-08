# Lab 1C Bonus-A: Private EC2 with VPC Endpoints

## Overview
This guide provides clear and simple instructions for deploying a private EC2 instance with VPC endpoints. VPC endpoints allow your EC2 instance to connect to AWS services without using public internet. This enhances security and performance. 

## Architecture Diagram
![Architecture Diagram](https://example.com/architecture-diagram.png)  
*(Insert a link to the architecture diagram here.)*

## Step-by-Step Deployment Instructions
1. **Log in to the AWS Management Console.**  
   Go to [AWS Management Console](https://aws.amazon.com/console/).

2. **Create a VPC.**  
   Go to the VPC section and click on 'Create VPC'.  
   - Select IPv4 CIDR block (e.g., 10.0.0.0/16).

3. **Create Subnets.**  
   Go to 'Subnets' and create two subnets:  
   a. Public Subnet (e.g., 10.0.1.0/24)  
   b. Private Subnet (e.g., 10.0.2.0/24)

4. **Create Internet Gateway.**  
   Go to 'Internet Gateways', create one, and attach it to your VPC.

5. **Create Route Tables.**  
   Create appropriate route tables for public and private subnets.

6. **Launch EC2 Instance in Private Subnet.**  
   Choose your AMI (Amazon Machine Image) and ensure it’s in the private subnet.

7. **Set up Security Groups.**  
   Define inbound and outbound rules for your EC2 instance.

8. **Create VPC Endpoint.**  
   Go to 'Endpoints', create an endpoint to connect to necessary AWS services.

## Verification Tests
1. **Check EC2 Instance Status:**  
   Ensure the instance is running and accessible within the VPC.

2. **Test VPC Endpoint:**  
   Use the endpoint to connect to selected AWS services.

3. **Ping Test:**  
   From your EC2 instance, ping other instances within the VPC.

4. **Access Services via Endpoints:**  
   Validate connection to S3 or other services using the endpoint.

5. **Monitor Logs:**  
   Check CloudWatch logs for any unusual activity.

6. **Test Security Group Rules:**  
   Verify that security controls are operational by testing allowed and blocked traffic.

7. **Review IAM Permissions:**  
   Ensure your IAM role has the necessary permissions for endpoint access.

## Troubleshooting Guide
- **Instance not reachable:** Check security group settings and VPC configuration.  
- **VPC endpoint issues:** Ensure that the policy attached to the endpoint allows necessary actions.
- **Network connectivity problems:** Verify routing tables and subnet associations.

## IAM Role Explanation
The IAM role associated with your EC2 instance should have permissions to access VPC endpoints. Ensure you attach policies that allow relevant actions such as `s3:GetObject` for S3 endpoint access.

## Cleanup Instructions
1. **Terminate EC2 Instance:**  
   Make sure you do this to avoid unwanted charges.
2. **Delete VPC and Subnets:**  
   Go to your VPC dashboard and delete the created resources.

## Quick Reference Commands
- **Check EC2 status:**  
   `aws ec2 describe-instances`  
- **List VPC endpoints:**  
   `aws ec2 describe-vpc-endpoints`  
- **Delete EC2 instance:**  
   `aws ec2 terminate-instances --instance-ids <instance-id>`  

For more AWS commands visit the [AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/index.html).

Happy deploying!
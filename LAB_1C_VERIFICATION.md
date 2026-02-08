Lab 1C - Terraform Infrastructure Verification

Date:** 2026-02-08 12:34:40  
User:** jayekamau-1991  
Status:** 

All Verifications Complete

---

Part 1: terraform plan Output

Run the following to generate the plan:
```bash
tf plan > terraform-plan.txt
```

---
Part 2: terraform apply Evidence

Terraform Apply Completed Successfully**

All resources deployed:
- VPC: vpc-048bf26795c0e25a2
- EC2: i-045acf0743869742d (34.230.64.95)
- RDS: kamau-rds01
- CloudWatch Log Group: /aws/ec2/kamau-rds-app
- SNS Topic: arn:aws:sns:us-east-1:533972479438:kamau-db-incidents
- Secrets Manager: kamau/rds/mysql
- SSM Parameters: /lab/db/*

---

Part 3: CLI Verification Commands

Command 1: Verify VPC 

Command:
```bash
aws ec2 describe-vpcs --filters "Name=vpc-id,Values=vpc-048bf26795c0e25a2" --query 'Vpcs[0]'
```

Output:
```json
{
    "OwnerId": "533972479438",
    "InstanceTenancy": "default",
    "CidrBlockAssociationSet": [
        {
            "AssociationId": "vpc-cidr-assoc-034507517eeea9e78",
            "CidrBlock": "10.0.0.0/16",
            "CidrBlockState": {
                "State": "associated"
            }
        }
    ],
    "IsDefault": false,
    "Tags": [
        {
            "Key": "Name",
            "Value": "kamau-vpc01"
        }
    ],
    "BlockPublicAccessStates": {
        "InternetGatewayBlockMode": "off"
    },
    "VpcId": "vpc-048bf26795c0e25a2",
    "State": "available",
    "CidrBlock": "10.0.0.0/16",
    "DhcpOptionsId": "dopt-0025e32215e1eb324"
}
```

Verification:
- VPC ID: vpc-048bf26795c0e25a2
- CIDR Block: 10.0.0.0/16
- State: available
- Name: kamau-vpc01
- Owner: 533972479438

---

### Command 2: Verify EC2 

Command:
```bash
aws ec2 describe-instances --instance-ids i-045acf0743869742d --query 'Reservations[0].Instances[0]'
```

Output (Key Details):
```json
{
    "Architecture": "x86_64",
    "EbsOptimized": false,
    "EnaSupport": true,
    "Hypervisor": "xen",
    "IamInstanceProfile": {
        "Arn": "arn:aws:iam::533972479438:instance-profile/kamau-instance-profile01",
        "Id": "AIPAXYUZ5NXHLTJHL7H4R"
    },
    "NetworkInterfaces": [
        {
            "Association": {
                "IpOwnerId": "amazon",
                "PublicDnsName": "ec2-34-230-64-95.compute-1.amazonaws.com",
                "PublicIp": "34.230.64.95"
            }
        }
    ],
    "BlockDeviceMappings": [
        {
            "DeviceName": "/dev/sda1",
            "Ebs": {
                "AttachTime": "2026-02-08T11:38:04+00:00",
                "DeleteOnTermination": true,
                "Status": "attached",
                "VolumeId": "vol-0e9cb8a78b0d3b7aa",
                "EbsCardIndex": 0
            }
        }
    ]
}
```

Verification:
- Instance ID: i-045acf0743869742d
- Public IP: 34.230.64.95
- IAM Instance Profile: kamau-instance-profile01
- EBS Volume: vol-0e9cb8a78b0d3b7aa
- Hypervisor: xen
- Architecture: x86_64

---

### Command 3: Verify RDS

**Command:**
```bash
aws rds describe-db-instances --db-instance-identifier kamau-rds01 --query 'DBInstances[0]'
```

Output (Key Details):
```json
{
    "PerformanceInsightsEnabled": false,
    "DeletionProtection": false,
    "AssociatedRoles": [],
    "TagList": [
        {
            "Key": "Name",
            "Value": "kamau-rds01"
        }
    ],
    "CustomerOwnedIpEnabled": false,
    "NetworkType": "IPV4",
    "ActivityStreamStatus": "stopped",
    "BackupTarget": "region",
    "CertificateDetails": {
        "CAIdentifier": "rds-ca-rsa2048-g1",
        "ValidTill": "2027-02-08T11:40:08Z"
    },
    "DedicatedLogVolume": false,
    "IsStorageConfigUpgradeAvailable": false,
    "EngineLifecycleSupport": "open-source-rds-extended-support"
}
```

Verification:
- DB Instance: kamau-rds01
- Engine: MySQL
- Network Type: IPV4
- Backup Target: region
- Certificate Valid Until: 2027-02-08
- Status: Available

---

### Command 4: Verify CloudWatch Alarm 

**Command:**
```bash
aws cloudwatch describe-alarms --alarm-names "kamau-db-connection-failure" --query 'MetricAlarms[0]'
```

Output:
```json
{
    "AlarmConfigurationUpdatedTimestamp": 1770550658.433,
    "ActionsEnabled": true,
    "OKActions": [],
    "AlarmActions": [
        "arn:aws:sns:us-east-1:533972479438:kamau-db-incidents"
    ],
    "InsufficientDataActions": [],
    "StateValue": "INSUFFICIENT_DATA",
    "StateReason": "Unchecked: Initial alarm creation",
    "StateUpdatedTimestamp": 1770550658.433,
    "MetricName": "DBConnectionErrors",
    "Namespace": "Lab/RDSApp",
    "Statistic": "Sum",
    "Dimensions": [],
    "Period": 300,
    "EvaluationPeriods": 1,
    "Threshold": 3.0,
    "ComparisonOperator": "GreaterThanOrEqualToThreshold",
    "TreatMissingData": "missing",
    "StateTransitionedTimestamp": 1770550658.433
}
```

**Verification:**
- Alarm Name: kamau-db-connection-failure
- Metric Name: DBConnectionErrors
- Namespace: Lab/RDSApp
- Threshold: 3 errors per 5 minutes (300 seconds)
- State: INSUFFICIENT_DATA (initial - no data yet)
- SNS Topic: arn:aws:sns:us-east-1:533972479438:kamau-db-incidents
- Actions Enabled: true
- Comparison Operator: GreaterThanOrEqualToThreshold

---

Command 5: Verify SNS Topic 

Command:
```bash
aws sns get-topic-attributes --topic-arn arn:aws:sns:us-east-1:533972479438:kamau-db-incidents --query 'Attributes'
```

Output:
```json
{
    "Policy": "{\"Version\":\"2008-10-17\",\"Id\":\"__default_policy_ID\",\"Statement\":[{\"Sid\":\"__default_statement_ID\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"*\"},\"Action\":[\"SNS:GetTopicAttributes\",\"SNS:SetTopicAttributes\",\"SNS:AddPermission\",\"SNS:RemovePermission\",\"SNS:DeleteTopic\",\"SNS:Subscribe\",\"SNS:ListSubscriptionsByTopic\",\"SNS:Publish\"],\"Resource\":\"arn:aws:sns:us-east-1:533972479438:kamau-db-incidents\",\"Condition\":{\"StringEquals\":{\"AWS:SourceOwner\":\"533972479438\"}}}] ",
    "LambdaSuccessFeedbackSampleRate": "0",
    "Owner": "533972479438",
    "SubscriptionsPending": "1",
    "TopicArn": "arn:aws:sns:us-east-1:533972479438:kamau-db-incidents",
    "EffectiveDeliveryPolicy": "{\"http\":{\"defaultHealthyRetryPolicy\":{\"minDelayTarget\":20,\"maxDelayTarget\":20,\"numRetries\":3,\"numMaxDelayRetries\":0,\"numNoDelayRetries\":0,\"numMinDelayRetries\":0,\"backoffFunction\":\"linear\"},\"disableSubscriptionOverrides\":false,\"defaultRequestPolicy\":{\"headerContentType\":\"text/plain; charset=UTF-8\"}}}",
    "FirehoseSuccessFeedbackSampleRate": "0",
    "SubscriptionsConfirmed": "0",
    "SQSSuccessFeedbackSampleRate": "0",
    "HTTPSuccessFeedbackSampleRate": "0",
    "ApplicationSuccessFeedbackSampleRate": "0",
    "DisplayName": "",
    "SubscriptionsDeleted": "1"
}
```

Verification:
- Topic ARN: arn:aws:sns:us-east-1:533972479438:kamau-db-incidents
- Owner: 533972479438
- Subscriptions Pending: 1 (waiting for confirmation)
- Subscriptions Confirmed: 0
- Policy: Allows all SNS actions from AWS account 533972479438


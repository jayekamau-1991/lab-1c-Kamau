# Bonus-B: Application Load Balancer with HTTPS, WAF, and Monitoring

## What is Bonus-B?

Bonus-B adds a **public Application Load Balancer (ALB)** in front of your private EC2 from Bonus-A.

### What You're Building

```
Internet Users
    ↓
Domain: app.kamaus-labs.online
    ↓
Route53 DNS
    ↓
ALB (Public, Port 80 & 443)
    ↓
WAF (Firewall Rules)
    ↓
TLS Certificate (HTTPS)
    ↓
Private EC2 (from Bonus-A)
    ↓
S3 (Access Logs) + CloudWatch (Monitoring)
```

---

## Files in This Directory

| File | Purpose |
|------|---------|
| `bonus_b_variables.tf` | Configuration variables |
| `bonus_b_alb_security_groups.tf` | ALB security group (ports 80, 443) |
| `bonus_b_acm.tf` | TLS certificate for HTTPS |
| `bonus_b_route53.tf` | Route53 hosted zone & DNS records |
| `bonus_b_alb.tf` | Application Load Balancer |
| `bonus_b_waf.tf` | Web Application Firewall |
| `bonus_b_logging.tf` | S3 bucket for ALB logs |
| `bonus_b_monitoring.tf` | CloudWatch alarms & SNS notifications |
| `bonus_b_outputs.tf` | Output values for testing |

---

## How It Works (Step by Step)

### Step 1: User Visits Your Website
```
User types: https://app.kamaus-labs.online
```

### Step 2: Route53 Looks It Up
```
Route53 finds: app.kamaus-labs.online → ALB DNS Name
```

### Step 3: ALB Receives Request
```
ALB listens on:
- Port 80 (HTTP) → redirects to HTTPS
- Port 443 (HTTPS) → serves your app
```

### Step 4: WAF Checks Request
```
WAF rules check:
- Is this a real user?
- Is this a SQL injection attack?
- Is this XSS?
- If bad → block it
If good → forward to EC2
```

### Step 5: TLS Certificate Validates
```
Browser checks certificate for app.kamaus-labs.online
Certificate says: "This is real!"
Browser encrypts data
```

### Step 6: Request Goes to EC2
```
ALB sends to target group
Target group sends to EC2 (port 80)
EC2 app responds
```

### Step 7: Response Goes Back
```
EC2 → ALB → User
Data is encrypted (HTTPS)
```

### Step 8: Logs and Monitoring
```
ALB logs request → S3
CloudWatch tracks metrics
If 5xx errors → SNS sends email alert
```

---

## Before You Deploy

### 1. You Need Bonus-A
✅ Private VPC
✅ Private EC2 with app running on port 80
✅ VPC endpoints for AWS services

### 2. You Need a Domain
✅ You have: `kamaus-labs.online` (from Namecheap)

### 3. Update Variables (Optional)
Edit `bonus_b_variables.tf` if you want to change:
- Domain name
- ALB name
- Email for alerts
- WAF settings
- Monitoring thresholds

---

## Deployment Instructions

### Step 1: Initialize Terraform

```bash
terraform init
```

**What it does:**
- Downloads AWS provider
- Sets up backend
- Validates configuration

### Step 2: Plan Deployment

```bash
terraform plan -out=bonus-b.tfplan
```

**What it shows:**
- What will be created
- Security group rules
- ALB configuration
- WAF rules
- Everything!

**Review the output and make sure it looks right.**

### Step 3: Apply Deployment

```bash
terraform apply bonus-b.tfplan
```

**What happens:**
- Creates ALB (takes ~2 minutes)
- Creates Route53 hosted zone
- Creates ACM certificate
- Creates WAF rules
- Creates S3 bucket
- Creates CloudWatch alarms
- Creates SNS topic

**Wait for it to complete!** You should see:
```
Apply complete! Resources added: 15.

Outputs:
alb_dns_name = "kamaus-alb01-1234567890.us-east-1.elb.amazonaws.com"
app_domain = "https://app.kamaus-labs.online"
route53_nameservers = ["ns-123...", "ns-456...", ...]
```

### Step 4: Update Namecheap DNS

After deployment, you'll see Route53 nameservers in the output.

**In Namecheap:**
1. Log in to your account
2. Find `kamaus-labs.online`
3. Click "Manage"
4. Find "Nameservers"
5. Select "Custom DNS"
6. Add the 4 nameservers from Terraform output
7. Click Save
8. Wait 24-48 hours for DNS to propagate

**Example nameservers:**
```
ns-123.awsdns-12.com
ns-456.awsdns-34.com
ns-789.awsdns-56.com
ns-012.awsdns-78.com
```

### Step 5: Verify DNS Propagation

Wait 24-48 hours, then test:

```bash
# Check if DNS is propagated
nslookup app.kamaus-labs.online

# Should return ALB DNS name
# Name: app.kamaus-labs.online
# Address: 54.123.45.67 (ALB's IP)
```

---

## Testing Your Setup

### Test 1: ALB is Responding

```bash
# Get ALB DNS from Terraform output
ALB_DNS="kamaus-alb01-1234567890.us-east-1.elb.amazonaws.com"

# Test HTTP (should redirect)
curl -I http://$ALB_DNS
# Should see: HTTP/1.1 301 Moved Permanently
# Location: https://...
```

### Test 2: HTTPS is Working

```bash
# Test HTTPS
curl -I https://$ALB_DNS
# Should see: HTTP/1.1 200 OK
```

### Test 3: Domain is Working (After DNS Propagation)

```bash
# Test domain
curl -I https://app.kamaus-labs.online
# Should see: HTTP/1.1 200 OK
```

### Test 4: Check ALB Logs

```bash
# List S3 bucket
aws s3 ls s3://kamaus-alb-logs-123456789/

# Download log
aws s3 cp s3://kamaus-alb-logs-123456789/your-log.gz .
gunzip your-log.gz
cat your-log
```

### Test 5: Check CloudWatch Metrics

```bash
# List available metrics
aws cloudwatch list-metrics --namespace AWS/ApplicationELB

# Get request count
aws cloudwatch get-metric-statistics \
  --namespace AWS/ApplicationELB \
  --metric-name RequestCount \
  --dimensions Name=LoadBalancer,Value=kamaus-alb01 \
  --start-time 2026-02-01T00:00:00Z \
  --end-time 2026-02-15T23:59:59Z \
  --period 3600 \
  --statistics Sum
```

---

## Troubleshooting

### Problem: ALB Not Responding

```bash
# Check ALB status
aws elbv2 describe-load-balancers --names kamaus-alb01

# Check target health
aws elbv2 describe-target-health --target-group-arn arn:aws:elasticloadbalancing:...
```

**Solutions:**
- Make sure EC2 is running
- Make sure EC2 has app on port 80
- Check EC2 security group allows ALB

### Problem: Domain Not Working

```bash
# Check DNS
nslookup app.kamaus-labs.online

# If not working:
# 1. Wait 24-48 hours
# 2. Verify nameservers in Namecheap
# 3. Check Route53 records
```

### Problem: Certificate Not Validated

```bash
# Check certificate status
aws acm describe-certificate --certificate-arn arn:aws:acm:...
```

**Solutions:**
- Route53 record must exist
- Wait 5 minutes for AWS validation
- Check Route53 hosted zone is correct

### Problem: EC2 Not Getting Traffic

```bash
# Check target health
aws elbv2 describe-target-health --target-group-arn ...

# Should show: State = healthy
```

**Solutions:**
- Check EC2 security group allows port 80 from ALB
- Check EC2 has web server running
- Check health check path returns HTTP 200

### Problem: Getting 502/503 Errors

```bash
# Check ALB logs
aws s3 cp s3://kamaus-alb-logs-xxx/ . --recursive

# Check CloudWatch metrics
aws cloudwatch list-metrics --namespace AWS/ApplicationELB
```

**Solutions:**
- EC2 might be down
- EC2 app might be crashed
- Port 80 not responding
- Health checks failing

---

## Key Concepts Explained

### Application Load Balancer (ALB)
- **What:** Distributes traffic to EC2 instances
- **Why:** High availability, can handle millions of requests
- **Ports:** 80 (HTTP) and 443 (HTTPS)

### Target Group
- **What:** Logical grouping of EC2 instances
- **Why:** ALB sends traffic to target group, which routes to EC2
- **Health Checks:** Every 30 seconds, checks if EC2 is alive

### Security Group
- **What:** Virtual firewall
- **Rules:** Allow port 80 & 443 from internet, block everything else

### TLS Certificate (HTTPS)
- **What:** Digital passport proving your domain is real
- **Why:** Encrypts data between user and ALB
- **How:** ACM manages it automatically

### Route53
- **What:** DNS service (phone book for internet)
- **Why:** Converts `app.kamaus-labs.online` → ALB IP
- **How:** Uses ALIAS record (AWS-specific)

### WAF (Web Application Firewall)
- **What:** Protects ALB from attacks
- **Rules:** Blocks SQL injection, XSS, bots, etc.
- **Why:** Free AWS Managed Rules

### S3 Logging
- **What:** ALB saves access logs to S3
- **Why:** Debugging, analytics, compliance
- **Format:** One log file per ALB request batch

### CloudWatch Alarms
- **What:** Monitors metrics and sends alerts
- **Why:** Know when something goes wrong
- **Alert:** 5xx errors → SNS email

---

## Cost Estimate

| Service | Cost/Month | Notes |
|---------|-----------|-------|
| ALB | ~$16 | ~$0.0225/hour |
| Domain | ~$0.10 | $1.18/year |
| ACM | FREE | AWS Certificate Manager is free |
| Route53 | ~$0.50 | Hosted zone + queries |
| WAF | ~$5 | $5 + $0.60 per million requests |
| CloudWatch | < $1 | Free tier covers most |
| S3 | < $1 | Logs are cheap storage |
| **TOTAL** | **~$23/month** | Very affordable! |

---

## What's Next?

### Option 1: Add Auto Scaling
- Create launch template
- Create auto scaling group
- Automatically scale EC2 based on load

### Option 2: Add RDS Database
- Create RDS instance
- Update EC2 to connect to RDS
- Persist data in database

### Option 3: Add CloudFront
- Cache content worldwide
- Reduce ALB load
- Faster for users globally

### Option 4: Add API Gateway
- Create REST API
- Add API rate limiting
- Monitor API usage

---

## Security Best Practices

✅ **Do:**
- Keep EC2 private (only ALB accesses it)
- Use HTTPS only (HTTP redirects)
- Enable WAF rules
- Monitor CloudWatch
- Review S3 logs
- Patch EC2 regularly

❌ **Don't:**
- Expose EC2 to internet
- Disable WAF
- Ignore alerts
- Use default passwords
- Leave HTTP open
- Disable health checks

---

## Questions?

If something doesn't work:

1. **Check Terraform output**
   ```bash
   terraform output
   ```

2. **Check AWS Console**
   - ALB status
   - Target group health
   - Route53 records
   - WAF rules
   - CloudWatch metrics

3. **Check logs**
   ```bash
   # ALB logs
   aws s3 ls s3://kamaus-alb-logs-xxx/
   
   # CloudWatch logs
   aws logs describe-log-groups
   ```

4. **Test connectivity**
   ```bash
   # Test ALB
   curl -I http://ALB-DNS
   
   # Test domain
   curl -I https://app.kamaus-labs.online
   
   # Test EC2
   ssh -i key.pem ubuntu@PRIVATE-IP
   ```

---

## Summary

You now have:
✅ Public ALB in front of private EC2
✅ HTTPS with TLS certificate
✅ DNS routing to your domain
✅ WAF protecting your app
✅ Access logs in S3
✅ CloudWatch monitoring
✅ SNS alerts for errors

Your app is now **production-ready**! 🚀

Good luck! 💪

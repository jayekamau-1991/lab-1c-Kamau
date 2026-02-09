Bonus-B: Application Load Balancer with HTTPS

What is This?

Bonus-B puts a **public load balancer** in front of your private EC2 from Bonus-A.

It provides:
- Public ALB (internet-facing)
- HTTPS with TLS certificate
- Route53 DNS (app.kamaus-labs.online)
- WAF firewall protection
- Access logging (S3)
- CloudWatch monitoring

---

## Quick Diagram

```
Internet → Route53 DNS → ALB → WAF → EC2 (private)
                                   ↓
                            S3 Logs + CloudWatch
```

---

## Deployment

```bash
# 1. Initialize
terraform init

# 2. Plan
terraform plan -out=bonus-b.tfplan

# 3. Apply
terraform apply bonus-b.tfplan

# 4. Update Namecheap DNS with Route53 nameservers (wait 24-48 hours)
```

---
Testing

```bash
Get ALB DNS from terraform output
terraform output alb_dns_name

# Test ALB responds
curl -I https://ALB-DNS-NAME

Test domain (after DNS propagates)
curl -I https://app.kamaus-labs.online
```

---

Files

- `bonus_b_variables.tf` - Configuration
- `bonus_b_alb_security_groups.tf` - Security rules
- `bonus_b_acm.tf` - HTTPS certificate
- `bonus_b_route53.tf` - DNS setup
- `bonus_b_alb.tf` - Load balancer
- `bonus_b_waf.tf` - Firewall
- `bonus_b_logging.tf` - S3 logs
- `bonus_b_monitoring.tf` - Alarms
- `bonus_b_outputs.tf` - Test outputs

---

Troubleshooting

ALB not responding?**
- Check EC2 is running
- Check EC2 has app on port 80
- Check target group health

Domain not working?**
- Check Route53 nameservers added to Namecheap
- Wait 24-48 hours for DNS propagation
- Test with: `nslookup app.kamaus-labs.online`

Certificate validation failed?**
- Wait 5 minutes
- Check Route53 record exists

---

Done! Simple and to the point. 🚀

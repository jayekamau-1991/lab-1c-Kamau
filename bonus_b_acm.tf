# ACM Certificate Validation Records for DNS Validation

## DNS Records

1. **Type:** CNAME  
   **Name:** _abc.example.com  
   **Value:** _xyz.acm-validations.aws  
   **TTL:** 300

   - Replace `abc` with the actual validation token provided by ACM.  
   - Replace `example.com` with your domain name.

2. **Type:** CNAME  
   **Name:** _def.example.com  
   **Value:** _uvw.acm-validations.aws  
   **TTL:** 300

   - Replace `def` with the second validation token provided by ACM.  
   - Replace `example.com` with your domain name.

## Instructions  
- Add these records to your DNS provider.  
- Wait for the validation to complete before continuing with the certificate issuance process.
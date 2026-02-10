Lab 1a study Armageddon

Logged into AWS and worked through an RDS + EC2 + Secrets Manager lab, focusing on getting a simple notes web app running.

Verified your RDS MySQL instance, its endpoint, and especially the security group inbound rule to allow MySQL (3306) only from the EC2 security group, not the internet.

Reviewed your Secrets Manager secret, confirmed it was created as RDS credentials and that its JSON contained username, password, host, port, and dbInstanceIdentifier.

Tracked down your local .pem key on your Mac (under Documents/theowaf/Class 7/Labs/Armageddon), fixed its permissions, and successfully SSH’d into the EC2 instance using the correct key and username.

On the EC2 instance, created and ran a bootstrap script that:

Installed Python, Flask, PyMySQL, and Boto3.

Wrote a Flask app to /opt/rdsapp/app.py that uses Secrets Manager to fetch DB credentials and connect to RDS.

Created and enabled a rdsapp systemd service to run the app on port 80.

Confirmed the app service was active (running) and used system logs to diagnose an “Internal Server Error” on /init, discovering a NoCredentialsError from Boto3.

Verified that an IAM role with secretsmanager:GetSecretValue was attached to the instance and that instance metadata returned temporary credentials, then exported those credentials into environment variables so the app could call Secrets Manager successfully.

Retested /init until it succeeded in creating the labdb database and notes table in RDS.

Added multiple notes via /add?note=... and verified them with /list in the browser, preparing the required screenshots (RDS SG inbound, EC2 IAM role, and /list showing at least three notes).

Clarified and documented the lab’s short‑answer concepts: limiting DB access to the EC2 SG, MySQL using port 3306, and why Secrets Manager is better than hard‑coding credentials.

Thread is getting long. Start a new one for better answers.

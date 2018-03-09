# Terraform-Ansible-Swarm-AWS
Using Terraform to deploy 6 swarm machines on AWS using ansible to configure swarm/compose and install a simple compose nginx app

### Docker Swarm
![alt text](imgs/swarm1.png#center "Login")

### AWS AccessKey e SecretAccessKey
Set these variables in dep.sh:

* export AWS_SECRET_ACCESS_KEY=""
* export AWS_DEFAULT_REGION=""
* export AWS_ACCESS_KEY_ID=""

### dep.sh script
Sets up your environment using terraform. Be sure to have terraform installed and on PATH.
#### Syntax
<pre>sh dep.sh [TERRAFORM_DIR] [apply|destroy|plan|init]</pre>
1. init
2. plan
3. apply
IF fails, do yourself the rollback (TERRAFORM won't rollback for you)
4. destroy

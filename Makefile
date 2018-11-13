.PHONY:

ROOT = $(shell pwd)

KEYPATH=$(shell awk '/^private_key_path/ {print $$3}' identity.tfvars | tr -d '"' | tail -n1)
TFSTATE_BUCKET=$(shell awk '/^tfstate_bucket/ {print $$3}' variables.tfvars | tr -d '"' | tail -n1)
BUCKET_KEYPATH=$(shell awk '/^bucket_keypath/ {print $$3}' variables.tfvars | tr -d '"' | tail -n1)

export AWS_ACCESS_KEY_ID = $(shell awk '/^aws_access_key/ {print $$3}' identity.tfvars | tr -d '"' | tail -n1)
export AWS_SECRET_ACCESS_KEY = $(shell awk '/^aws_secret_key/ {print $$3}' identity.tfvars | tr -d '"' | tail -n1)
export AWS_DEFAULT_REGION = $(shell awk '/^aws_region/ {print $$3}' variables.tfvars | tr -d '"' | tail -n1)

TFVARS=-var-file $(ROOT)/variables.tfvars -var-file $(ROOT)/identity.tfvars

HOST_PLAN=$(ROOT)/hosts/hosts.tfplan

plan:
	@cd $(ROOT)/hosts;$(ROOT)/bin/setupremote.sh $(TFSTATE_BUCKET) $(BUCKET_KEYPATH)
	@cd $(ROOT)/hosts;terraform get;terraform plan $(TFVARS) -input=false -out=$(HOST_PLAN)

deploy:
	@cd $(ROOT)/hosts;$(ROOT)/bin/setupremote.sh $(TFSTATE_BUCKET) $(BUCKET_KEYPATH)
	@cd $(ROOT)/hosts;terraform get;echo "yes" | terraform apply -input=false $(HOST_PLAN)

destroy:
	@cd $(ROOT)/hosts;$(ROOT)/bin/setupremote.sh $(TFSTATE_BUCKET) $(BUCKET_KEYPATH)
	@cd $(ROOT)/hosts;terraform get;echo "yes" | terraform destroy -force $(TFVARS)

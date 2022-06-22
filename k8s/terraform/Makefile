CREDS := credentials.json

DEFAULT_ENV := ${ENV:-dev}
DEFAULT_REGION := europe-west1
DEFAULT_CREDS := ${CREDS}

POSSIBLE_ENVS := dev test pre pro
POSSIBLE_REGION := europe-west1

ENV ?= ${DEFAULT_ENV}
REGION ?= ${DEFAULT_REGION}
GCP_CREDENTIALS := ~/.config/gcloud/${DEFAULT_CREDS}

ifeq ($(filter $(ENV),$(POSSIBLE_ENVS)),)
    $(error ENV "$(ENV)" not in [$(POSSIBLE_ENVS)])
endif

ifeq ($(filter $(REGION),$(POSSIBLE_REGION)),)
    $(error REGION "$(REGION)" not in [$(POSSIBLE_REGION)])
endif

VARIABLES_CONFIG := ../config/${ENV}/terraform.tfvars
BACKEND_CONFIG := ../config/${ENV}/config_backend.tfvars

TERRAFORM_VERSION := 1.1.4

.ONESHELL:

version:
	docker run terraform version

init:
	docker run  \
	-v ${PWD}:/home -v ${GCP_CREDENTIALS}:/root/.config/gcloud/credentials.json \
	-w /home/project \
	-e GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/credentials.json \
	hashicorp/terraform:${TERRAFORM_VERSION} \
	init --backend-config="${BACKEND_CONFIG}"

#rules for gitlab ci
init-ci:
	cd project; terraform init --backend-config=${BACKEND_CONFIG}

validate-ci:
	cd project; terraform validate 

plan-ci:
	cd project; terraform plan 	-var-file="${VARIABLES_CONFIG}"  -var credentials="/root/.config/gcloud/credentials.json" 

plan-json-ci:
	cd project; terraform plan 	-var-file="${VARIABLES_CONFIG}"  -var credentials="/root/.config/gcloud/credentials.json"  -out tf.plan

apply-ci: 
	cd project; terraform apply	-var-file="${VARIABLES_CONFIG}"   -var credentials="/root/.config/gcloud/credentials.json" -auto-approve
#end rules gitlab ci


validate:
	docker run -i -t \
	-v ${PWD}:/home \
	-w /home/project \
	hashicorp/terraform:${TERRAFORM_VERSION} \
	validate

plan:
	docker run -i -t \
	-v ${PWD}:/home -v ${GCP_CREDENTIALS}:/root/.config/gcloud/credentials.json \
	-w /home/project \
	-e GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/credentials.json \
	hashicorp/terraform:${TERRAFORM_VERSION} plan \
	-var-file="${VARIABLES_CONFIG}"  \
	-var credentials="/root/.config/gcloud/credentials.json"


apply:
	docker run -i -t \
	-v ${PWD}:/home -v ${GCP_CREDENTIALS}:/root/.config/gcloud/credentials.json \
	-w /home/project \
	-e GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/credentials.json \
	hashicorp/terraform:${TERRAFORM_VERSION} apply \
	-var-file="${VARIABLES_CONFIG}"  \
	-var credentials="/root/.config/gcloud/credentials.json"

graph:
	docker run -i -t \
	-v ${PWD}:/home \
	-w /home/project \
	hashicorp/terraform:${TERRAFORM_VERSION} graph -type=plan

clean:
	rm -rf project/.terraform/

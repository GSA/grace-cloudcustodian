parts = $(subst -, ,$(CIRCLE_USERNAME))
environment := $(shell echo "$(word 2,$(parts))" | tr '[:lower:]' '[:upper:]')
environments := PRODUCTION STAGING TEST

ifeq ($(filter $(environment),$(environments)),)
	export environment = DEVELOPMENT
endif

.PHONY: check apply plan validate init
check:
ifeq ($(strip $(backend_bucket)),)
	@echo "backend_bucket must be provided"
	@exit 1
endif
ifeq ($(strip $(TF_VAR_appenv)),)
	@echo "TF_VAR_appenv must be provided"
	@exit 1
else
	@echo "appenv: $(TF_VAR_appenv)"
endif
ifeq ($(strip $(backend_key)),)
	@echo "backend_key must be provided"
	@exit 1
endif

apply: plan
	terraform apply --auto-approve

plan: validate
	terraform plan

validate: init
	terraform validate

init: check
	terraform init -backend-config="bucket=$(backend_bucket)" -backend-config="key=$(backend_key)"

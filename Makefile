.PHONY: help init clean validate mock create delete info deploy
.DEFAULT_GOAL := help
environment = "example"

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

create: ## create env
	@sceptre launch-env $(environment)

delete: clean ## delete env
	@sceptre delete-env $(environment)

clean: ##
	aws s3 rm --recursive s3://`sceptre --output json describe-stack-outputs example bucket | jq -r '.[] | select(.OutputKey="DeployBucketName") | .OutputValue'`

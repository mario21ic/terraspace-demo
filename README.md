# Terraspace Project

This is a Terraspace project. It contains code to provision Cloud infrastructure built with [Terraform](https://www.terraform.io/) and the [Terraspace Framework](https://terraspace.cloud/).

## Deploy

To deploy all the infrastructure stacks:

    terraspace all up

To deploy individual stacks:

    terraspace up demo # where demo is app/stacks/demo

## Terrafile

To use more modules, add them to the [Terrafile](https://terraspace.cloud/docs/terrafile/).

## Using basic examples
```
export TS_ENV=dev
terraspace up demo

export TS_ENV=prod
terraspace seed newstack

export AWS_REGION=us-east-2
export TS_ENV=test
terraspace all up
```

Aws secrets:
```
aws secretsmanager create-secret --name demo-dev-user --secret-string bob
aws secretsmanager create-secret --name demo-dev-pass --secret-string mypass
aws secretsmanager list-secrets
aws secretsmanager get-secret-value --secret-id demo-dev-user
terraspace up secrets
```

Hooks:
```
terraspace new hook demo --type stack
cat app/stacks/demo/config/hooks/terraform.rb
terraspace up demo

terraspace new hook demo --type stack --kind terraspace
cat app/stacks/demo/config/hooks/terraspace.rb
terraspace build demo
```

Helpers:
```
terraspace new helper demo --type stack
cat app/stacks/demo/config/helpers/demo_helper.rb

terraspace up demo
```

Testing Harness:
```
./terraspace.sh new test demohardness
ls -la spec/
./terraspace test
```

Testing Module-level:
```
./terraspace.sh new test example --type module
cat app/modules/example/test/spec/main_spec.rb

cd app/modules/example
bundle
terraspace test

ls -la .terraspace-cache/us-east-1/test/modules/example
tail /tmp/terraspace/log/init/example.log
ls -la /tmp/terraspace/test-harnesses/example-harness
ls -la /tmp/terraspace/plans/example-*/*.plan
```

Testing Stack-level:
```
./terraspace.sh new test demo --type stack
ls -la app/stacks/demo/test

cd app/stacks/demo
bundle
terraspace test
ls -la /tmp/terraspace/test-harnesses/demo-harness
```

Arg CLI
```
terraspace new arg --type project
cat config/args/terraform.rb
terraspace up demo -y

terraspace new arg --type stack newstack
cat app/stacks/newstack/config/args/terraform.rb
terraspace up newstack -y
```

Dependencies
```
cat app/stacks/secrets/tfvars/dev.tfvars
terraspace up secrets
terraspace all graph
```

Terraform Modules
```
cat Terrafile
cat app/stacks/newstack/main.tf

terraspace bundle
ls -la vendor/modules
ls -la app/stacks/vpc

terraspace bundle info s3
terraspace bundle info sg
terraspace bundle info vpc

terraspace up newstack -y
```

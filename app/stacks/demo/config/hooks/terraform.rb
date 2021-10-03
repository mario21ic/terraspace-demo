before("apply",
  #execute: "echo 'app/stacks/demo/config/hooks/terraform.rb: test stack before hook for terraform apply'",
  execute: "pwd && terraform validate ."
)

#after("apply",
#  execute: "echo 'app/stacks/demo/config/hooks/terraform.rb: test stack after hook for terraform apply'"
#)

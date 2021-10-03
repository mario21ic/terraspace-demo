command("apply",
  #args: ["-lock-timeout=5m", '-var="myKey=valueFromCLI"'],
  args: ["-lock-timeout=5m"],
  env: {TF_VAR_myKey: "valueFromArgApply"},
  var_files: ["a.tfvars", "b.tfvars"],
)

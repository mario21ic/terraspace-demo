describe "main" do
  before(:all) do
    mod_path = File.expand_path("../..", __dir__) # the source of the module to test is 2 levels up
    # Build terraspace project to use as a test harness
    # Will be located at: /tmp/terraspace/test-harnesses/example-harness
    terraspace.build_test_harness(
      name: "example-harness",
      modules: {example: mod_path},
      # See: https://terraspace.cloud/docs/testing/test-harness/
      # config: "spec/fixtures/config",
      tfvars: {example: "spec/fixtures/tfvars/test.tfvars"},
    )
    terraspace.up("example")
  end
  after(:all) do
    terraspace.down("example")
  end

  it "successful deploy" do
    #expect(true).to be true
    
    pp terraspace.outputs
    output_value = terraspace.output("example", "name")
    #expect(output_value).to include("terraform-")
    expect(output_value).to eq("bucket-test-terraspace")
  end
end

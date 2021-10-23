#before("build",
#  execute: "echo 'app/stacks/demo/config/hooks/terraspace.rb: test stack before hook for terraspace build'",
#)

#after("build",
#  execute: "echo 'app/stacks/demo/config/hooks/terraspace.rb: test stack after hook for terraspace build'"
#)

class ShowContext
  def call(runner)
    mod = runner.mod

    puts "runner #{runner}"
    puts "runner.hook #{runner.hook}"

    puts "mod #{mod}"
    puts "mod.name #{mod.name}"
    puts "mod.build_dir #{mod.build_dir}"
    puts "mod.cache_dir #{mod.cache_dir}"
    puts "mod.root #{mod.root}"
    puts "mod.type #{mod.type}"
    puts "mod.type_dir #{mod.type_dir}"
    puts "mod.options #{mod.options}"

    puts("Terraspace.root #{Terraspace.root}")
    puts("Terraspace.env #{Terraspace.env}")

    # Example of creating an expander. Note: Interface may change
    expander = TerraspacePluginAws::Interfaces::Expander.new(mod)
    puts "expander.account #{expander.account}"
  end
end

before("build",
  execute: ShowContext,
)

#class EnvExporter
#  def call
#    ENV['SECRET_FOO'] = "bar"
#  end
#end

#before("build",
#  execute: EnvExporter,
#)

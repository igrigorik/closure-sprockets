class ClosureDirectiveProcessor < Sprockets::DirectiveProcessor
  def process_require_closure_directive(path)
    # Locate python script that helps us to calculate deps
    # cmd = File.expand_path "../bin/build/closurebuilder.py", File.dirname(__FILE__)
    
    # Use old one script, coz it could calculate deps much easier for begginers without any project's namespaces
    cmd = File.expand_path "../bin/calcdeps.py", File.dirname(__FILE__)
    
    # Get only application lookup paths
    context.environment.paths.select{ |p| p if p.include? context.environment.root }.each do |path|
      # cmd << " --root=#{path}" # for closurebuilder.py script
      cmd << " --path=#{path}"
    end

    # closurebuilder.py needs some input files to start deps searching
    file_pathname = context.resolve path
    cmd << " --input=#{file_pathname}"
    
    # Read stdout result and split it by strings
    # results = `#{cmd}`.split "\n" # for closurebuilder.py script
    results = `#{cmd} --output_mode=list`.split "\n"
    
    # Finally require calculated deps
    results.each{|dep| context.require_asset dep };
  end
end
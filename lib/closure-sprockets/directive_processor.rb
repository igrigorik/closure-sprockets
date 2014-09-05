require "sprockets/directive_processor"

module Closure
  module Sprockets
    class DirectiveProcessor < ::Sprockets::DirectiveProcessor
      def process_require_closure_directive(path)
        # Locate python script that helps us to calculate deps
        # cmd = File.expand_path "../bin/build/closurebuilder.py", File.dirname(__FILE__)

        # Use old one script, coz it could calculate deps much easier for begginers without any project's namespaces
        cmd = File.expand_path "../bin/calcdeps.py", File.dirname(__FILE__)

        # Get only application lookup paths
        context.environment.paths.each do |p|
          # cmd << " --root=#{p}" # for closurebuilder.py script
          cmd << " --path=#{p}"
        end

        # closurebuilder.py needs some input files to start deps searching
        file_pathname = context.resolve path
        cmd << " --input=#{file_pathname}"

        # Read stdout result and split it by strings
        # results = `#{cmd}`.split "\n" # for closurebuilder.py script
        results = `#{cmd} --output_mode=list`.split "\n"

        # Finally require calculated assets
        results.each{|asset| context.require_asset asset };
      end
    end
  end
end

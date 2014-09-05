require 'shellwords'

module Closure
  module Sprockets
    class SoyTemplateProcessor < Tilt::Template
      COMPILER_ROOT = File.expand_path(File.dirname(__FILE__))
      COMPILER_JAR  = File.join(COMPILER_ROOT, "/../jar/SoyToJsSrcCompiler.jar")

      self.default_mime_type = 'application/javascript'

      def self.engine_initialized?; true; end
      def initialize_engine; end
      def prepare; end

      def evaluate(context, locals, &block)
        context.require_asset 'soyutils'

        # not the prettiest way to do this, but it works, for now...
        out = file.gsub(/soy$/, 'soyjs')
        `java -jar #{COMPILER_JAR.shellescape} --outputPathFormat #{out.shellescape} #{file.shellescape}`

        @output = IO.read(out)
        File.delete(out)

        @output
      end
    end
  end
end

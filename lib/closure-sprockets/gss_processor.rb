class GssTemplateProcessor < Tilt::Template
  COMPILER_ROOT = File.expand_path(File.dirname(__FILE__))
  COMPILER_JAR  = File.join(COMPILER_ROOT, "/../jar/closure-stylesheets.jar")

  self.default_mime_type = 'text/css'

  def self.engine_initialized?; true; end
  def initialize_engine; end
  def prepare; end

  def evaluate(context, locals, &block)
    # not the prettiest way to do this, but it works, for now...
    out = file.gsub(/gss$/, 'css')
    `java -jar #{COMPILER_JAR} --output-file #{out} --pretty-print #{file}`

    @output = IO.read(out)
    File.delete(out)

    @output
  end
end

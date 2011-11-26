class ClosureDependenciesProcessor < Tilt::Template
  def prepare; end

  def evaluate(context, locals, &block)
    context.require_asset 'goog/base'
    context.require_asset 'soyutils'

    data.lines.each do |line|

      if line =~ /goog\.require\s*\(\s*[\'\"]([^\)]+)[\'\"]\s*\)/
        goog, mod, sub = $1.split(".")
        next if mod =~ /^Test/
        sub = mod if sub.nil?

        dep = [goog, mod, sub].compact.join("/")
        context.require_asset(dep)
      end
    end

    data
  end
end

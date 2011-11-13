module ClosureProcessor
  class Railtie < Rails::Engine
    config.closure = ActiveSupport::OrderedOptions.new
    config.closure.lib = 'vendor/assets/closure-library/closure'

    initializer :setup_closure do |app|
      app.assets.append_path config.closure.lib
      app.assets.append_path 'vendor/assets'

      app.assets.register_preprocessor 'application/javascript', ClosureDependenciesProcessor
      app.assets.register_engine '.soy', SoyTemplateProcessor
      app.assets.register_engine '.gss', GssTemplateProcessor
    end

  end
end

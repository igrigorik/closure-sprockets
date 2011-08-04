module ClosureProcessor
  class Railtie < Rails::Railtie
    config.closure = ActiveSupport::OrderedOptions.new
    config.closure.lib = 'vendor/assets/closure-library/closure'

    initializer :setup_closure do |app|
      app.assets.append_path config.closure.lib
      app.assets.register_preprocessor 'application/javascript', ClosureDependenciesProcessor
    end

  end
end

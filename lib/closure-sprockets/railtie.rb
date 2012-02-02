module ClosureProcessor
  class Railtie < Rails::Engine
    initializer :setup_closure do |app|
      # For developing purposes, Sprockets used to cache a lot even when server restarted
      # app.assets.cache = false
      
      app.assets.unregister_preprocessor 'application/javascript', Sprockets::DirectiveProcessor
      app.assets.register_preprocessor 'application/javascript', ClosureDirectiveProcessor
      
      app.assets.register_engine '.soy', SoyTemplateProcessor
      app.assets.register_engine '.gss', GssTemplateProcessor
    end

  end
end

require "tilt"

require "closure/sprockets/version"
require "closure/sprockets/directive_processor"
require "closure/sprockets/soy_processor"
require "closure/sprockets/gss_processor"
require "closure/sprockets/railtie" if defined?(Rails)

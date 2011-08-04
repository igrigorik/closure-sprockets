# Closure Sprockets

Sprockets processor for Google's [Closure tools](http://code.google.com/closure/).

## Integrating with Rails 3

If you want to use closure as your JS library in Rails 3, add the gem to your Gemfile:

```ruby
gem 'closure-sprockets'
gem 'closure-compiler' # optional, see below
````

If you also want to use the closure compressor to minify your Javascript, then change your environment config to:

```ruby
config.assets.js_compressor = Closure::Compiler.new
```

Finally, [download the latest version](http://code.google.com/closure/library/docs/gettingstarted.html) of closure library from Google and put it in `vendor/assets`.

## Optional configuration

If you decided to put your `closure-library` directory somewhere other than `vendor/assets`, then you'll have to update your environment config with the right path:

```ruby
config.closure.lib = 'vendor/assets/path/to/closure-library
```

### License

(MIT License) - Copyright (c) 2011 Ilya Grigorik
# Closure Sprockets

Sprockets preprocessor for Google's [Closure tools](http://code.google.com/closure/) + Closure-templates (soy) compiler.

## Integrating with Rails 3

If you want to use closure as your Javascript library in Rails 3, add this gem to your Gemfile:

```ruby
gem 'closure-sprockets'
````
The gem ships with a Railtie which will automatically register a Closure preprocessor. From here, two more steps:

- [Download the latest version](http://code.google.com/closure/library/docs/gettingstarted.html) of closure library from Google and put it in `vendor/assets`
- Write some closure code!

```js
// in one of your javascript files
goog.require('goog.dom');

newHeader = goog.dom.createDom('h1', {}, 'Hello world!');
goog.dom.appendChild(document.body, newHeader);
```

You can also add a `name.soy` template in your assets folder, and it will be automatically compiled to Javascript for you! Ex:

```js
/** hello.soy */

{namespace examples.simple}

/**
 * Says hello to the world.
 */
{template .helloSoy}
  Hello from Soy!
{/template}
```

```js
var soy = goog.dom.createDom('h1', {'style': 'background-color:#EEE'}, examples.simple.helloSoy());
goog.dom.appendChild(document.body, soy);
```

That's it! Point your browser at your page and you should have a hello world greeting from Google Closure, preprocessed by the Rails 3 Asset Pipeline and without any external Python dependencies or dynamic Javascript loading.

## Optional configuration

If you decided to put your `closure-library` directory somewhere other than `vendor/assets`, then you'll have to update your environment config with the right path:

```ruby
config.closure.lib = 'vendor/assets/path/to/closure-library'
```

## Using Closure Compressor for Minification

Closure also provides its own Javascript compressor. If you wish to use it, pull in the [closure-compiler](https://github.com/documentcloud/closure-compiler) gem:

```ruby
# in your Gemfile
gem 'closure-compiler'
````

```ruby
# in your environment configuration
config.assets.js_compressor = Closure::Compiler.new
```

If you are not using the closure compiler, then you may want to disable the dynamic deps.js loading. To do so, add the following snippet in `application.html.erb` above the javascript_include tag:

```html
    <script type="text/javascript">
      var CLOSURE_NO_DEPS = true;
    </script>
```

### License

(MIT License) - Copyright (c) 2011 Ilya Grigorik
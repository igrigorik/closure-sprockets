# Closure Sprockets

Sprockets preprocessor for Google's [Closure tools](http://code.google.com/closure/) + Closure-templates (soy) compiler + Closure stylesheets (gss) compiler.

## Integrating with Rails 3

If you want to use closure as your Javascript library in Rails 3, add this gem to your Gemfile:

```ruby
gem 'closure-sprockets'
````
The gem ships with a Railtie which will automatically register a Closure preprocessor. From here, two more steps:

- [Download the latest version](http://code.google.com/closure/library/docs/gettingstarted.html) of closure library from Google and put it in `vendor/assets`
- Write some closure code!


### Javascripts

```js
// in one of your javascript files
goog.require('goog.dom');

function sayHello() {
  newHeader = goog.dom.createDom('h1', {}, 'Hello world!');
  goog.dom.appendChild(document.body, newHeader);
};

window.onload = sayHello;
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


### Stylesheets

You can use also [closure stylesheets](http://code.google.com/p/closure-stylesheets/) in .gss files

```css
/** style.gss **/

@def BG_COLOR              rgb(235, 239, 249);

@def DIALOG_BORDER_COLOR   rgb(107, 144, 218);
@def DIALOG_BG_COLOR       BG_COLOR;

body {
  background-color: BG_COLOR;
}

.dialog {
  background-color: DIALOG_BG_COLOR;
  border: 1px solid DIALOG_BORDER_COLOR;
}
```

GSS files will be compiled automatically to CSS:

```css
body {
  background-color: #ebeff9;
}
.dialog {
  background-color: #ebeff9;
  border: 1px solid #6b90da;
}
```



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

# grunt-webpage-scaffold

> Help build the new Webpage project, static resource automatic generation of page demo file and dependence (optional without JS file). Once to initialize grunt, open the default browser to observe the compiled Demo. At the same time will automatically start the Livereload pattern of development, we can start coding: )

## Getting Started
This plugin requires Grunt `~0.4.5`

```shell
npm install grunt-webpage-scaffold --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-webpage-scaffold');
```

## The "webpage_scaffold" task

### Overview

In Gruntfile, you need some config ,for example:

    module.exports = (grunt) ->
      grunt.initConfig
        webpage:
          options:
            #coffee: 'coffee/page/'
            js: 'js/page/'
            less: 'less/page/'
            lessCommonCode: '@import "../var";'
            demo: 'demos/'
            demoShowPath: 'http://localhost/git/moc/build/demos/'
            tplPath: '.tpl'

### Options

#### options.js
Type: `String`
Default value: `'js/page/'`

A string value that is used to determine where to generate js file. __It's 'mutually exclusive with options.coffee__

#### options.coffee
Type: `String`
Default value: `''`

A string value that is used to determine where to generate coffee file. __It's 'mutually exclusive with options.js__

#### options.less
Type: `String`
Default value: `'less/page/'`

A string value that is used to determine where to generate less file.

#### options.lessCommonCode
Type: `String`
Default value: `''`

A string value that is used to write __something common__ into less file at the top.

#### options.demo
Type: `String`
Default value: `'demo/'`

A string value that is used to determine where to generate html demo file.

#### options.demoShowPath
Type: `String`
Default value: `'./build/demos/'`

A string value that is used to determine what url to open in browser for preview.

#### options.tplPath
Type: `String`
Default value: `'.tpl'`

A string value that is used to determine which template file to use for generate demo file..

### Default Options

```
    opt = this.options(
      coffee: false
      js: 'js/page/'
      less: 'less/page/'
      lessCommonCode: ''
      demo: 'demos/'
      demoShowPath: './build/demos/'
      tplPath: '.tpl'
    )
```

## Contributing

welcome!

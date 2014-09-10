/*
 grunt-webpage-scaffold
 https://github.com/Mickey-/webpage-scaffold

 Copyright (c) 2014 Mickey-
 Licensed under the MIT license.
*/


(function() {
  'use strict';
  module.exports = function(grunt) {
    return grunt.registerMultiTask('webpage_scaffold', 'Help build the new Webpage project, static resource automatic generation of page demo file and dependence (optional without JS file). Once to initialize grunt, open the default browser to observe the compiled Demo. At the same time will automatically start the Livereload pattern of development, we can start coding: )', function() {
      var options;
      options = this.options({
        punctuation: '.',
        separator: ', '
      });
      return this.files.forEach(function(f) {
        var src;
        src = f.src.filter(function(filepath) {
          if (!grunt.file.exists(filepath)) {
            grunt.log.warn('Source file "' + filepath + '" not found.');
            return false;
          } else {
            return true;
          }
        }).map(function(filepath) {
          return grunt.file.read(filepath);
        }).join(grunt.util.normalizelf(options.separator));
        src += options.punctuation;
        grunt.file.write(f.dest, src);
        return grunt.log.writeln('File "' + f.dest + '" created.');
      });
    });
  };

}).call(this);

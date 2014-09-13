/*
 * grunt-webpage-scaffold
 * https://github.com/Mickey-/webpage-scaffold
 *
 * Copyright (c) 2014 Mickey-
 * Licensed under the MIT license.
 */

'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    jshint: {
      all: [
        'Gruntfile.js',
        'tasks/*.js',
        '<%= nodeunit.tests %>'
      ],
      options: {
        jshintrc: '.jshintrc'
      }
    },

    // Before generating any new files, remove any previously-created files.
    clean: {
      tests: ['tmp']
    },
    coffee: {
      compile: {
        expand: true,
        cwd: 'tasks/',
        src: ['webpage_scaffold.coffee'],
        dest: 'tasks/',
        ext: '.js'
      }
    },

    // Configuration to be run (and then tested).
    webpage_scaffold: {
    /*
      default_options: {
        options: {
        },
        files: {
          'tmp/default_options': ['test/fixtures/testing', 'test/fixtures/123']
        }
      },
      custom_options: {
        options: {
          separator: ': ',
          punctuation: ' !!!'
        },
        files: {
          'tmp/custom_options': ['test/fixtures/testing', 'test/fixtures/123']
        }
      },
      */
      options: {
        //coffee: 'coffee/page/',
        js: 'js/page/',
        less: 'less/page/',
        //sass: 'sass/page/',
        demo: 'demos/',
        watchPath: 'http://localhost/git/moc/build/demos/',
        tplPath: '.tpl'
      }
    },

    // Unit tests.
    nodeunit: {
      tests: ['test/*_test.js']
    }

  });

  // Actually load this plugin's task(s).
  grunt.loadTasks('tasks');

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-nodeunit');
  grunt.loadNpmTasks('grunt-contrib-coffee');

  grunt.registerTask('test', ['clean', 'webpage_scaffold', 'nodeunit']);

  // By default, lint and run all tests.
  grunt.registerTask('default', ['jshint', 'test']);

  //test build new project
  grunt.registerTask('build', ['webpage_scaffold']);

};

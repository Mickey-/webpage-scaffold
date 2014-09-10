/*
 * grunt-webpage-scaffold
 * https://github.com/Mickey-/webpage-scaffold
 *
 * Copyright (c) 2014 Mickey-
 * Licensed under the MIT license.
 */

'use strict'

module.exports = (grunt) -> {


  grunt.registerMultiTask('webpage_scaffold', 'Help build the new Webpage project, static resource automatic generation of page demo file and dependence (optional without JS file). Once to initialize grunt, open the default browser to observe the compiled Demo. At the same time will automatically start the Livereload pattern of development, we can start coding: )', () ->{
    #Merge task-specific and/or target-specific options with these defaults.
    options = this.options({
      punctuation: '.',
      separator: ', '
    })

    # Iterate over all specified file groups.
    this.files.forEach( (f) -> {
      # Concat specified files.
      src = f.src.filter((filepath) -> {
        # Warn on and remove invalid source files (if nonull was set).
        if (!grunt.file.exists(filepath)) {
          grunt.log.warn('Source file "' + filepath + '" not found.')
          return false
        } else {
          return true
        }
      }).map((filepath) -> {
        # Read file source.
        return grunt.file.read(filepath)
      }).join(grunt.util.normalizelf(options.separator))

      # Handle options.
      src += options.punctuation

      # Write the destination file.
      grunt.file.write(f.dest, src)

      # Print a success message.
      grunt.log.writeln('File "' + f.dest + '" created.')
    })
  })

}

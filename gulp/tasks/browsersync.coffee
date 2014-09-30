browserSync = require 'browser-sync'
gulp = require 'gulp'

gulp.task 'browserSync', ['build'], ->
  browserSync
    server:
      baseDir: ['client/']
    files: [
      # watch everything in dist
      'client/dist/**'
    ]

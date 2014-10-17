browserSync = require 'browser-sync'
gulp = require 'gulp'

gulp.task 'browserSync', ['nodemon', 'build'], ->
  browserSync
    proxy: '0.0.0.0:5000'
    port: 5001
    files: [
      # watch everything in dist
      'client/dist/**'
    ]

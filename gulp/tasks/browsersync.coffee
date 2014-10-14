browserSync = require 'browser-sync'
gulp = require 'gulp'

gulp.task 'browserSync', ['nodemon', 'build'], ->
  browserSync
    proxy: 'localhost:3000'
    port: 4001
    files: [
      # watch everything in dist
      'client/dist/**'
    ]

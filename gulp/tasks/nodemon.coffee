gulp = require 'gulp'
nodemon = require 'gulp-nodemon'
browserSync = require 'browser-sync'

gulp.task 'nodemon', ->
  nodemon
    script: 'server.coffee'
    ext: 'coffee'
    ignore: ['client/*', 'node_modules/*']
  .on 'restart', ->
    setTimeout ->
      browserSync.reload stream: false
    , 1000
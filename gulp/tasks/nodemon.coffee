gulp = require 'gulp'
nodemon = require 'gulp-nodemon'
browserSync = require 'browser-sync'

gulp.task 'nodemon', ->
  nodemon
    script: 'server.coffee'
    ignore: ['./client']
  .on 'restart', ->
    setTimeout ->
      browserSync.reload stream: false
    , 1000
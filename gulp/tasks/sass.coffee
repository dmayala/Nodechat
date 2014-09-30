gulp = require 'gulp'
sass = require 'gulp-sass'
handleErrors = require '../util/handle_errors'

gulp.task 'sass', ->
  gulp.src('./client/src/css/*.scss')
      .pipe(sass())
      .pipe(gulp.dest './client/dist/css' )
gulp = require 'gulp'
handleErrors = require '../util/handle_errors'

gulp.task 'pipeVendorCSS', ->

  gulp.src('./client/src/js/vendor/bootstrap/dist/**/*')
      .pipe(gulp.dest './client/dist' )

  gulp.src('./client/src/js/vendor/bootstrap-material-design/dist/**/*')
      .pipe(gulp.dest './client/dist' )
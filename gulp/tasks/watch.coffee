###
Notes:
  - gulp/tasks/browserify.coffee handles coffee recompiling with watchify
  - gulp/tasks/browsersync.coffee watches and reloads compiled files
###

gulp = require 'gulp'

gulp.task 'watch', ['setWatch', 'browserSync'], ->
  gulp.watch 'client/src/css/**', ['sass']
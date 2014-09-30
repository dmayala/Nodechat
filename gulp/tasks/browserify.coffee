###
browserify task
---------------
Bundle javascripty things with browserify!

If the watch task is running, this uses watchify instead
of browserify for faster bundling using caching.
###

browserify   = require 'browserify'
watchify     = require 'watchify'
bundleLogger = require '../util/bundle_logger'
gulp         = require 'gulp'
handleErrors = require '../util/handle_errors'
source       = require 'vinyl-source-stream'

gulp.task 'browserify', ->
  bundler = browserify({
    # required watchify args
    cache: {}, packageCache: {}, fullPaths: true,
    # specify app entry point
    entries: ['./client/src/js/initialize.coffee'],
    # file extensions
    extensions: ['.coffee', '.hbs']
    # Enable source maps
    debug: true
  })

  bundle = ->
    # log when bundling starts
    bundleLogger.start()

    bundler
      .bundle()
      # report compile error
      .on 'error', handleErrors
      # make stream gulp compatible - specify output name
      .pipe source 'app.js'
      # specify output destination
      .pipe gulp.dest './client/dist/js'
      # log when bundling completes
      .on 'end', bundleLogger.end

  if global.isWatching
    bundler = watchify(bundler)
    bundler.on 'update', bundle

  return bundle()
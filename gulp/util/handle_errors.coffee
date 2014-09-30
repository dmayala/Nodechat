notify = require('gulp-notify')

module.exports = ->
  args = Array.prototype.slice.call(arguments)

  # Send error to notification center with gulp-notify
  notify.onError({
    title: 'Compile Error',
    message: "<%= error.message %>"
  }).apply(@, args)

  # keep gulp from hanging on this task
  @emit 'end'
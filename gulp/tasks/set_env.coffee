gulp = require 'gulp'

# config dependencies
_ = require 'underscore'
ini = require 'ini'
fs = require 'fs'

if fs.existsSync './.env'
  # read config
  config = ini.parse fs.readFileSync './.env', 'utf-8'

  gulp.task 'setEnv', ->
    # add config to process.env
    _.extend process.env, config
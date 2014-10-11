Handlebars = require 'hbsfy/runtime'
moment = require 'moment'

Handlebars.registerHelper 'timeFormat', (context, options) ->
  format = 'hh:mm:ss'
  moment(context).format(format)

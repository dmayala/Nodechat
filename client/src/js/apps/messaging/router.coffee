Marionette = require 'backbone.marionette'

class Router extends Marionette.AppRouter
  appRoutes:
    'messaging': 'showMessaging'

module.exports = Router


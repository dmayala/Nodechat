# require dependencies
Marionette = require 'backbone.marionette'
Radio = require './radio'

# require modules
SocketsModule = require './apps/sockets/module'

# create application namespace
App = new Marionette.Application();

# add modules
App.module 'sockets', SocketsModule

module.exports = App
Marionette = require 'backbone.marionette'

class Layout extends Marionette.LayoutView
  template: require '../templates/show/layout'

  regions:
    messagesRegion: '#messages-region'
    usersRegion: '#users-region'

module.exports = Layout
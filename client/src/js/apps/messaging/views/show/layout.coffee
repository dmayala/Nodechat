Marionette = require 'backbone.marionette'

class Layout extends Marionette.LayoutView
  template: require '../templates/show/layout'

  className: 'col-md-12 maxheight'
    
  regions:
    messagesRegion: '#messages-region'
    usersRegion: '#users-region'

  events:
    'keydown #msgIn': 'send'

  send: (e) ->
    if (e.keyCode == 13)
      e.preventDefault()
      @trigger 'message:outbound', $(e.currentTarget).val()
      $(e.currentTarget).val('')

module.exports = Layout
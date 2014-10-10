Radio = require '../../../radio'

# require models/collections
Message = require '../models/message'

# require views
LayoutShowView = require '../views/show/layout'
MessagesShowView = require '../views/show/messages'

showMessaging = ->
  Backbone.history.navigate 'messaging'
  layout = new LayoutShowView()

  fetchingMessages = Radio.reqres.request 'global', 'message:entities'

  $.when(fetchingMessages).done (messages) =>
    messagesShowView = new MessagesShowView collection: messages

    @listenTo layout, 'message:outbound', (outMessage) -> 
      newMessage = new Message
        timestamp: new Date()
        author: 'You'
        text: outMessage
      if newMessage.save()
        messages.add newMessage
        Radio.vent.trigger 'global', 'socket:outboundMsg', newMessage.get 'text'

    Radio.vent.on 'global', 'socket:inboundMsg', (inMessage) ->
      incomingMessage = new Message inMessage
      messages.add incomingMessage

    @listenTo layout, 'show', ->
      layout.messagesRegion.show messagesShowView

    @options.messagingRegion.show layout

module.exports = showMessaging
Radio = require '../../../radio'

# require models/collections
Message = require '../models/message'

# require views
LayoutShowView = require '../views/show/layout'
MessagesShowView = require '../views/show/messages'
UserEditView = require '../views/edit/user'

showMessaging = ->
  Backbone.history.navigate 'messaging'
  Radio.commands.execute 'global', 'set:active:menu', 'messaging'

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

    Radio.vent.on 'global', 'username:change', =>
      view = new UserEditView()

      view.on 'form:submit', (data) =>
        Radio.vent.trigger 'global', 'socket:changeName', data
        @options.dialogRegion.empty()

      @options.dialogRegion.show view

    @listenTo layout, 'show', ->
      layout.messagesRegion.show messagesShowView

    @options.messagingRegion.show layout

module.exports = showMessaging
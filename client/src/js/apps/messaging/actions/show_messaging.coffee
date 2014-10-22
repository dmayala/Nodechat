Radio = require '../../../radio'

# require models/collections
Message = require '../models/message'

# require views
LayoutShowView = require '../views/show/layout'
MessagesShowView = require '../views/show/messages'
UsersShowView = require '../views/show/users'
UserEditView = require '../views/edit/user'

showMessaging = ->
  Backbone.history.navigate 'messaging'
  Radio.commands.execute 'global', 'set:active:menu', 'messaging'

  layout = new LayoutShowView()

  fetchingMessages = Radio.reqres.request 'global', 'message:entities'
  fetchingUsers = Radio.reqres.request 'global', 'user:entities'

  $.when(fetchingMessages, fetchingUsers).done (messages, users) =>
    messagesShowView = new MessagesShowView collection: messages
    usersShowView = new UsersShowView collection: users

    @listenTo layout, 'message:outbound', (outMessage) -> 
      newMessage = new Message
        timestamp: new Date()
        author: 'Guest'
        text: outMessage
      if newMessage.save()
        messages.add newMessage
        Radio.vent.trigger 'global', 'socket:outboundMsg', newMessage.get 'text'

    Radio.vent.on 'global', 'socket:newUser', (newUser) ->
      users.add newUser

    Radio.vent.on 'global', 'socket:changeUser', (changedUser) ->
      user = users.get changedUser.id
      user.set changedUser
      users.trigger 'reset'

    Radio.vent.on 'global', 'socket:leaveUser', (id) ->
      users.remove users.get id

    Radio.vent.on 'global', 'socket:inboundMsg', (inMessage) ->
      incomingMessage = new Message inMessage
      messages.add incomingMessage

    Radio.vent.on 'global', 'nickname:change', =>
      view = new UserEditView()

      view.on 'form:submit', (data) =>
        Radio.vent.trigger 'global', 'socket:changeName', data
        @options.dialogRegion.empty()

      @options.dialogRegion.show view

    @listenTo layout, 'show', ->
      layout.messagesRegion.show messagesShowView
      layout.usersRegion.show usersShowView

    @options.messagingRegion.show layout

module.exports = showMessaging
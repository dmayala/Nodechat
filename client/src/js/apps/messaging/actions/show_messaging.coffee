Radio = require '../../../radio'

# require models/collections
Message = require '../models/message'

# require views
LayoutShowView = require '../views/show/layout'
MessagesShowView = require '../views/show/messages'
UsersShowView = require '../views/show/users'
UserEditView = require '../views/edit/user'
UserAvatarEditView = require '../views/edit/user_avatar'

showMessaging = ->
  @stopListening()
  Backbone.history.navigate 'messaging'
  Radio.commands.execute 'set:active:menu', 'messaging'

  layout = new LayoutShowView()

  fetchingMessages = Radio.reqres.request 'message:entities'
  fetchingUsers = Radio.reqres.request 'user:entities'
  fetchingPersonalId = Radio.reqres.request 'messaging:personalId'

  $.when(fetchingMessages, fetchingUsers).done (messages, users) =>

    messagesShowView = new MessagesShowView collection: messages
    usersShowView = new UsersShowView collection: users

    @listenTo layout, 'message:outbound', (outMessage) ->
      $.when(fetchingPersonalId).done (personalId) =>
        currentUser = users.get personalId
        newMessage = new Message
          timestamp: new Date()
          author: currentUser.get 'nickname'
          avatar: currentUser.get 'avatar'
          text: outMessage
        if newMessage.save()
          messages.add newMessage
          Radio.vent.trigger 'socket:outboundMsg', newMessage.get 'text'

    @listenTo Radio.vent, 'socket:newUser', (newUser) ->
      users.add newUser

    @listenTo Radio.vent, 'socket:changeUser', (changedUser) ->
      user = users.get changedUser.id
      user.set changedUser
      users.trigger 'reset'

    @listenTo Radio.vent, 'socket:leaveUser', (id) ->
      users.remove users.get id

    @listenTo Radio.vent, 'socket:inboundMsg', (inMessage) ->
      $.when(fetchingPersonalId).done (personalId) =>
        user = users.get personalId
        incomingMessage = new Message inMessage
        Radio.vent.trigger('messaging:unread:msg') if user.get('status') is false
        messages.add incomingMessage

    @listenTo Radio.vent, 'nickname:change', =>
      view = new UserEditView()

      view.on 'form:submit', (data) =>
        Radio.vent.trigger 'socket:changeName', data
        @options.dialogRegion.empty()

      @options.dialogRegion.show view

    @listenTo Radio.vent, 'avatar:change', =>
      $.when(fetchingPersonalId).done (personalId) =>
        view = new UserAvatarEditView personalId: personalId

        view.on 'avatar:form:success', (data) =>
          Radio.vent.trigger 'socket:changeAvatar', data
          @options.dialogRegion.empty()

        @options.dialogRegion.show view

    @listenTo layout, 'show', ->
      layout.messagesRegion.show messagesShowView
      layout.usersRegion.show usersShowView

    @options.messagingRegion.show layout

module.exports = showMessaging
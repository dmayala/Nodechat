# dependencies
socketIO = require 'socket.io'
moment = require 'moment'
UserEntity = require '../../entities/local_user'

exports.register = (plugin, options, next) ->

  io = socketIO.listen plugin.servers[0].listener

  io.sockets.on 'connection', (socket) ->

    # create/store username associated with this connection
    socketUser = null

    # login
    socket.on 'login', (candidateName) ->

      UserEntity.createUser {}, (err, user) ->

        socketUser = user

        socket.emit 'setPersonalId', socketUser.id

        io.emit 'serverMessage',
          timestamp: moment()
          author: 'SERVER'
          text: "#{socketUser.nickname} has logged in"
          newUser: socketUser

    # change name
    socket.on 'change:name', (user) ->
      oldnick = socketUser.nickname
      UserEntity.updateUser socketUser.id, nickname: user.nickname, (err, user) ->
        socketUser = user unless err
        io.emit 'change:name:success', 
          timestamp: moment()
          author: 'SERVER'
          text: "#{oldnick} will now be known as #{socketUser.nickname}"
          user: socketUser

    # change status
    socket.on 'change:status', (status) ->
      UserEntity.updateUser socketUser.id, status: status, (err, user) ->
        socketUser = user unless err
        io.emit 'change:status:success', socketUser

    # disconnect
    socket.on 'disconnect', ->
      if socketUser
        UserEntity.deleteUser socketUser.id, (err, user) ->
          unless err
            io.emit 'leave', 
              timestamp: moment()
              author: 'SERVER'
              text: "#{socketUser.nickname} has disconnected"
              user: socketUser
            socketUser = user
      
    # receiving/transmitting messages
    socket.on 'clientMessage', (text) -> 
      socket.broadcast.emit 'serverMessage',
        timestamp: moment()
        avatar: socketUser.avatar
        author: socketUser.nickname
        text: text
   
  next()

exports.register.attributes = pkg: require './package.json'


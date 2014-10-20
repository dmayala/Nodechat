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

        io.emit 'serverMessage',
          timestamp: moment()
          author: 'SERVER'
          text: "#{socketUser.nickname} has logged in"

    # change name
    socket.on 'change:name', (user) ->
      UserEntity.updateUser socketUser.id, nickname: user.nickname, (err, user) ->
        socketUser = user unless err

    # disconnect
    socket.on 'disconnect', ->
      if socketUser
        UserEntity.deleteUser socketUser.id, (err, user) ->
          socketUser = user unless err
      
    # receiving/transmitting messages
    socket.on 'clientMessage', (text) -> 
      socket.broadcast.emit 'serverMessage',
        timestamp: moment()
        author: socketUser.nickname
        text: text
   
  next()

exports.register.attributes = pkg: require './package.json'


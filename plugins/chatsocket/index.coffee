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

      socketUser = UserEntity.createUser()

      io.emit 'serverMessage',
        timestamp: moment()
        author: 'SERVER'
        text: "#{socketUser.nickname} has logged in"

    # change name
    socket.on 'change:name', (user) ->
      socketUser = UserEntity.updateUser socketUser.id, nickname: user.nickname

    # disconnect
    socket.on 'disconnect', ->
      socketUser = UserEntity.deleteUser(socketUser.id) if socketUser
      
    # receiving/transmitting messages
    socket.on 'clientMessage', (text) -> 
      socket.broadcast.emit 'serverMessage',
        timestamp: moment()
        author: socketUser.nickname
        text: text
   
  next()

exports.register.attributes = pkg: require './package.json'


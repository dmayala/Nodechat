# dependencies
_ = require 'underscore'
mongoose = require 'mongoose'
socketIO = require 'socket.io'

# track users
users = []

exports.register = (plugin, options, next) ->

  io = socketIO.listen plugin.servers[0].listener

  io.sockets.on 'connection', (socket) ->

    # login
    socket.on 'login', (username) ->
      id = mongoose.Types.ObjectId()

      user =
        id: id
        username: username

      #socket.set 'user', user, (err) ->
      #  throw err if err
      users.push user
      io.sockets.emit 'serverMessage', "#{user.username} has logged in"

    # receiving/transmitting messages
    socket.on 'clientMessage', (content) ->
      # socket.get 'user', (err, user) ->
      #   throw err if err
      #   broadcast = socket.broadcast
      #
      io.sockets.emit 'serverMessage',
        username: users[0].username
        content: content

  next()

exports.register.attributes = pkg: require './package.json'


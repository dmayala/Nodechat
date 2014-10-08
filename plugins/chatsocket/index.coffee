# dependencies
_ = require 'underscore'
mongoose = require 'mongoose'
socketIO = require 'socket.io'

# track names
names = []

# randomly generate names
createXNames = (x) ->
  if names.length <= x
    candidate = "Guest#{Math.floor(Math.random() * (x - 1) + 1)}"
    # rerun createXNames if name already taken
    if (names.indexOf(candidate) > -1) then createXNames(x) else candidate
  else "Guest"

exports.register = (plugin, options, next) ->

  io = socketIO.listen plugin.servers[0].listener

  io.sockets.on 'connection', (socket) ->

    # create/store username associated with this connection
    socketUsername = createXNames(10000)
    names.push socketUsername

    # login
    socket.on 'login', (candidateName) ->
      id = mongoose.Types.ObjectId()

      user =
        id: id
        name: socketUsername

      io.emit 'serverMessage', 
        author: 'SERVER'
        text: "#{user.name} has logged in"

    # disconnect
    socket.on 'disconnect', ->
      found = names.indexOf(socketUsername)
      names.splice(found, 1) if found > -1

    # receiving/transmitting messages
    socket.on 'clientMessage', (text) -> 
      socket.broadcast.emit 'serverMessage',
        author: socketUsername
        text: text
   
  next()

exports.register.attributes = pkg: require './package.json'


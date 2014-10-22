MessageEntity = require '../../entities/local_message'

exports.register = (plugin, options, next) ->

  plugin.route
    method: 'GET'
    path: '/api/messages'
    handler: (request, reply) -> 
      MessageEntity.getMessages (err, messages) ->
        reply err or messages

  plugin.route
    method: 'POST'
    path: '/api/messages'
    handler: (request, reply) ->
      MessageEntity.createMessage request.payload, (err, message) ->
        reply err or message

  ###
  plugin.route
    method: 'GET'
    path: '/api/users/{id}'
    handler: (request, reply) -> 
      UserEntity.getUser request.params.id, (err, user) ->
        reply err or user
  ###
               
  next()

exports.register.attributes = pkg: require './package.json'

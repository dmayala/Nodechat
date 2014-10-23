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
        
  next()

exports.register.attributes = pkg: require './package.json'

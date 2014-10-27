UserEntity = require '../../entities/local_user'

exports.register = (plugin, options, next) ->

  plugin.route
    method: 'GET'
    path: '/api/users'
    handler: (request, reply) -> 
      UserEntity.getUsers (err, users) ->
        reply err or users

  plugin.route
    method: 'GET'
    path: '/api/users/{id}'
    handler: (request, reply) -> 
      UserEntity.getUser request.params.id, (err, user) ->
        reply err or user
               
  next()

exports.register.attributes = pkg: require './package.json'

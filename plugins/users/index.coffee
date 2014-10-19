UserEntity = require '../../entities/local_user'

exports.register = (plugin, options, next) ->
  plugin.route
    method: 'GET'
    path: '/api/users'
    handler: (request, reply) -> reply UserEntity.getUsers()
      
  next()

exports.register.attributes = pkg: require './package.json'

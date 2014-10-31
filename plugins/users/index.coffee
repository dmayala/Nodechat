UserEntity = require '../../entities/local_user'
fs = require 'fs'

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

  plugin.route
    method: 'POST'
    path: '/api/users/avatar'
    config:
      payload:
        maxBytes: 209715200
        output: 'stream'
        parse: true
      handler: (request, reply) ->
        if request.payload?.file?
          id = request.payload.id
          fileName = "tmp/#{id}.png"
          ws = fs.createWriteStream fileName
          request.payload.file.pipe ws
          ws.on 'close', ->
            UserEntity.uploadAvatar id, fileName, (err, url) ->
              fs.unlink fileName
              reply err or url         
        else
          reply new Error()
               
  next()

exports.register.attributes = pkg: require './package.json'

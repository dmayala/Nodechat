# require dependencies
Hapi = require 'hapi'

# initial configuration 
host = process.argv[2] or '0.0.0.0'
port = Number(process.argv[3] or process.env.PORT) or 5000
options =
  views:
    engines: html: require 'handlebars'
    #path: './client'
    path: './views'

# create server
server = new Hapi.Server host, port, options

# routes
server.route
  method: 'GET'
  path: '/'
  handler: (request, reply) ->
    reply.view 'index'

server.route
  method: 'GET'
  path: '/dist/{file*}'
  #path: '/public/{file*}'
  handler: directory: path: './client/dist'

# register plugins
server.pack.register [
  { plugin: require './plugins/chatsocket' },
  { plugin: require './plugins/users' }
], (err) ->
  throw err if err

  # start server
  server.start ->
    console.log "Server running at #{server.info.uri}"

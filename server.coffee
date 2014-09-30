# require dependencies
Hapi = require 'hapi'

# initial configuration 
host = process.argv[2] || 'localhost'
port = Number(process.argv[3]) || 3000
options =
  views:
    engines: html: require 'handlebars'
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
  path: '/public/{file*}'
  handler: directory: path: './client/dist'

# register plugins
server.pack.register [
  { plugin: require './plugins/contact' }
], (err) ->
  throw err if err

  # start server
  server.start ->
    console.log "Server running at #{server.info.uri}"

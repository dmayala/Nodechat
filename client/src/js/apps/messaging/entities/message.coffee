Message = require '../models/message'
Messages = require '../collections/messages'
Radio = require '../../../radio'

getMessageEntity = (id) ->
  message = new Message id: id
  defer = $.Deferred()
  contact.fetch
    success: (data) -> defer.resolve data
    error: (data) -> defer.resolve undefined
  return defer.promise()

getMessageEntities = ->
  messages = new Messages()
  defer = $.Deferred()
  messages.fetch success: (data) ->
    defer.resolve data
  return defer.promise()

MessageAPI =
  initialize: ->
    @setHandlers()

  setHandlers: ->
    Radio.reqres.setHandler 'global', 'message:entity', (id) -> getMessageEntity(id)
    Radio.reqres.setHandler 'global', 'message:entities', -> getMessageEntities()

module.exports = MessageAPI


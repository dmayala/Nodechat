User = require '../models/user'
Users = require '../collections/users'
Radio = require '../../../radio'

getUserEntity = (id) ->
  user = new User id: id
  defer = $.Deferred()
  user.fetch
    success: (data) -> defer.resolve data
    error: (data) -> defer.resolve undefined
  return defer.promise()

getUserEntities = ->
  users = new Users()
  defer = $.Deferred()
  users.fetch
    success: (data) -> defer.resolve data
  return defer.promise()

UserAPI =
  initialize: ->
    @setHandlers()

  setHandlers: ->
    Radio.reqres.setHandler 'global', 'user:entity', (id) -> getUserEntity(id)
    Radio.reqres.setHandler 'global', 'user:entities', -> getUserEntities()

module.exports = UserAPI


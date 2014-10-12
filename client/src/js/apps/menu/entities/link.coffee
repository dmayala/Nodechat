LinkCollection = require '../collections/links'
Radio = require '../../../radio'

links = undefined

initializeLinks = ->
  links = new LinkCollection [
    { name: 'Chat', url: 'messaging', navigationTrigger: 'messaging:show' }
    { name: 'Change Username', url: 'messaging', navigationTrigger: 'username:change' }
  ]

API =
  getLinks: ->
    initializeLinks() unless links?
    links

LinksAPI =
  initialize: ->
    @setHandlers()

  setHandlers: ->
    Radio.reqres.setHandler 'global', 'link:entities', -> API.getLinks()

module.exports = LinksAPI

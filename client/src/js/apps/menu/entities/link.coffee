LinkCollection = require '../collections/links'
Radio = require '../../../radio'

links = undefined

initializeLinks = ->
  links = new LinkCollection [
    { name: 'Chat', url: 'messaging', navigationTrigger: 'messaging:show' }
    { name: 'Change Nickname', url: '', navigationTrigger: 'nickname:change' }
  ]

API =
  getLinks: ->
    initializeLinks() unless links?
    links

LinksAPI =
  initialize: ->
    @setHandlers()

  setHandlers: ->
    Radio.reqres.setHandler 'link:entities', -> API.getLinks()

module.exports = LinksAPI

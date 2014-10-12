Radio = require '../../../radio'
LinksListView = require '../views/list/links'

listMenu = ->
  links = Radio.reqres.request 'global', 'link:entities'
  view = new LinksListView collection: links

  view.on 'childview:navigate', (childView, args) ->
    trigger = args.model.get 'navigationTrigger'
    Radio.vent.trigger 'global', trigger

  @options.menuRegion.show view

module.exports = listMenu

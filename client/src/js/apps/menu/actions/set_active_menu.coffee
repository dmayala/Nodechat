Radio = require '../../../radio'

setActiveMenu = (linkUrl) ->
  links = Radio.reqres.request 'global', 'link:entities'
  linkToSelect = links.find (link) ->
    link.get('url') == linkUrl
  linkToSelect.select()
  links.trigger 'reset'

module.exports = setActiveMenu

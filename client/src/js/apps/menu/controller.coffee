BaseController = require './actions/base'

class Controller extends BaseController
  listMenu: require './actions/list_menu'
  setActiveMenu: require './actions/set_active_menu'

module.exports = Controller

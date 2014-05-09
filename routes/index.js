var SocketHandler = require('./socket');

module.exports = exports = function(app, io){
  var socketHandler = new SocketHandler(io);

  app.get('/users', socketHandler.getUsers);
}
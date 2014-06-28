var SocketHandler = require('./socket');

module.exports = exports = function(app, io, db){
  var socketHandler = new SocketHandler(io, db);

  app.get('/users', socketHandler.getUsers);
  app.get('/messages', socketHandler.getMessages);
}
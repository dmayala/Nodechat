ChatApp.module('Sockets',  function(Main, App, Backbone, Marionette, $, _) {
  var socket = io.connect('/');

  socket.on('serverMessage', function(content) {
    App.vent.trigger('serverMessage', content);
  });

  socket.on('login', function() {
    var username = prompt('What username would you like to use?'); 
    socket.emit('login', username);
  });

  socket.on('newuser', function(user) {
    App.vent.trigger('newuser', user);
  });

  App.vent.on('clientMessage', function (message) {
    socket.emit('clientMessage', message);
  });

  App.vent.on('join', function(args) {
    socket.emit('join', args);
  });
});
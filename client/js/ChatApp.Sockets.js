ChatApp.module('Sockets',  function(Main, App, Backbone, Marionette, $, _) {
  var socket = io.connect('/');

  socket.on('serverMessage', function(content) {
    App.vent.trigger('serverMessage', content);
  });

  socket.on('login', function() {
    var username = prompt('What username would you like to use?'); 
    socket.emit('login', username);
  });

  function sendCommand(command, args) {
    if (command === 'j') {
      socket.emit('join', args);
    } else {
      alert('unknown command: ' + command);
    }
  }

  function sendMessage(message) {
    var commandMatch = message.match(/^\/(\w*)(.*)/);
    if (commandMatch) {
      sendCommand(commandMatch[1], commandMatch[2].trim());
    } else {
      socket.emit('clientMessage', message);
    }
  }

  var inputElement = document.getElementById('input');

  inputElement.onkeydown = function(keyboardEvent) {
    if (keyboardEvent.keyCode === 13) {
      sendMessage(inputElement.value);
      inputElement.value = '';
      return false;
    } else {
      return true;
    }
  };
});
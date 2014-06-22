var _ = require('underscore');
var mongoose = require('mongoose');
var MessageDAO = require('../models/message').MessageDAO;

var users = [];
var init = function(io) {
  io.sockets.on('connection', function (socket) {
    socket.on('clientMessage', function(content) {
      socket.get('user', function (err, user) {
        if (!user.username) {
          user.username = socket.id;
        }

        socket.get('room', function (err, room) {
          if (err) { throw err; }
          var broadcast = socket.broadcast;
          var message = content;

          if (room) {
            broadcast.to(room);
          }

          io.sockets.emit('serverMessage', {'username': _.escape(user.username), 'content': _.escape(user.username) + ' said: ' + _.escape(content)});
        });

      });
    });
    
    socket.on('login', function (username) {

      var id = mongoose.Types.ObjectId();

      var user =  { 'id': _.escape(id), 'username': _.escape(username) }
      socket.set('user', user , function (err) {
        if (err) { throw err; } 
        users.push(user);
        io.sockets.emit('newuser', user);
        io.sockets.emit('serverMessage', {'username': user.username, 'content': 'User ' + user.username + ' logged in'});
      });
    }); 
    
    socket.on('disconnect', function() {
      socket.get('user', function(err, user) {

        if (user) {
          users.splice(users.indexOf(user), 1);

          io.sockets.emit('userquit', user);
          socket.broadcast.emit('serverMessage', {'username': user.username, 'content': 'User ' + user.username + ' disconnected'});
        }
      });
    });

    socket.on('join', function(room) {
      socket.get('room', function (err, oldRoom) {
        if (err) { throw err;}

        socket.set('room', room, function (err) {
          if (err) { throw err;}
          socket.join(room);

          if (oldRoom) {
            socket.leave(oldRoom);
          }
          socket.get('username', function (err, username) {
            if (!username) {
              username = socket.id;
            }
          });
          socket.get('username', function (err, username) {
            socket.emit('serverMessage', {'username': username, 'content': 'You joined room ' + room});
            if (!username) {
              username = socket.id;
            }
            socket.broadcast.to(room).emit('serverMessage', {'username': username, 'content': 'User ' + username + ' joined this room'});
          });
        });
      });
    });

    socket.emit('login');
  });
}


function SocketHandler(io, db) {
  var messages = new MessageDAO(db);

  init(io);

  this.getUsers = function(req, res, next) {
    res.json(users);
  }

  this.getMessages = function (req, res, next) {
    messages.getMessages(function(err, data) {
      res.json(data);
    });
  }
}

module.exports = SocketHandler;
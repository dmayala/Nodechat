
/**
 * Module dependencies.
 */

var express = require('express');
var http = require('http');
var path = require('path');

var app = express();
var server = http.createServer(app);
var io = require('socket.io').listen(server);


// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'client')));


// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

io.sockets.on('connection', function (socket) {
  socket.on('clientMessage', function(content) {
    socket.get('username', function (err, username) {
      socket.emit('serverMessage', {'username': username, 'content': 'You said: ' + content});
      if (!username) {
        username = socket.id;
      }
      socket.get('room', function (err, room) {
        if (err) { throw err; }
        var broadcast = socket.broadcast;
        var message = content;

        if (room) {
          broadcast.to(room);
        }
        broadcast.emit('serverMessage', {'username': username, 'content': username + ' said: ' + content});
      });
    });
  });
  
  socket.on('login', function (username) {
    socket.set('username', username, function (err) {
      if (err) { throw err; } 
      socket.emit('serverMessage', {'username': username, 'content': 'Currently logged in as ' + username} );
      socket.emit('newuser', {'username': username});
      socket.broadcast.emit('newuser', {'username': username});
      socket.broadcast.emit({'username': username, 'content': 'User ' + username + ' logged in'});
    });
  }); 
  
  socket.on('disconnect', function() {
    socket.get('username', function(err, username) {
      if (!username) {
        username = socket.id;
      }
      socket.broadcast.emit('serverMessage', {'username': username, 'content': 'User ' + username + ' disconnected'});
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

server.listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
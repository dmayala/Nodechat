
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

var users = [];

app.get('/users', function(req, res) {
  res.json(users);
});

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

        io.sockets.emit('serverMessage', {'username': user.username, 'content': user.username + ' said: ' + content});
      });

    });
  });
  
  socket.on('login', function (username ) {
    var user =  { 'id': users.length, 'username': username }
    socket.set('user', user , function (err) {
      if (err) { throw err; } 
      users.push(user);
      io.sockets.emit('newuser', user);
      io.sockets.emit('serverMessage', {'username': username, 'content': 'User ' + username + ' logged in'});
    });
  }); 
  
  socket.on('disconnect', function() {
    socket.get('user', function(err, user) {

      if (user) {
        delete users[user.id];

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

server.listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
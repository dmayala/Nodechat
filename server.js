var app = require('http').createServer(handler);
var io = require('socket.io').listen(app);
var fs = require('fs');


app.listen(3000);

function handler(req, res) {
  fs.readFile(__dirname + '/index.html', function (err, data) {
    if (err) {
      res.writeHead(500);
      return res.end('File not found');
    } 

    res.writeHead(200);
    res.end(data);
  });
}

io.sockets.on('connection', function (socket) {
  socket.on('clientMessage', function(content) {
    socket.emit('serverMessage', 'You said: ' + content);
    socket.get('username', function (err, username) {
      if (!username) {
        username = socket.id;
      } else {
        socket.broadcast.emit('serverMessage', username + ' said: ' + content);
      }
    });
  });
  
  socket.on('login', function (username) {
    socket.set('username', username, function (err) {
      if (err) { throw err; } 
      socket.emit('serverMessage', 'Currently logged in as ' + username);
      socket.broadcast.emit('serverMessage', 'User ' + username + ' logged in');
    });
  }); 
    socket.emit('login');
});




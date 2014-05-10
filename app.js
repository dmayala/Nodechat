var express = require('express');
var routes = require('./routes');
var http = require('http');
var path = require('path');

var mongoose = require('mongoose');

var app = express();
var server = http.createServer(app);
var io = require('socket.io').listen(server);

var mongoUri = 'mongodb://localhost/nodechat-dev';


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

// MongoDB
var db = mongoose.connect(mongoUri);

routes(app, io);

server.listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
# Nodechat 

A chat application meant to showcase the use of the following tools:

- [hapi.js](http://hapijs.com/)
- [Marionette.js](http://marionettejs.com/)
- [Socket.IO](http://socket.io/)
- [CoffeeScript](http://coffeescript.org/)
- [Gulp](http://gulpjs.com/)
- [Browserify](http://browserify.org/)

## Requirements
  - [node.js](http://nodejs.org/)
  - [Heroku Toolbelt](https://toolbelt.heroku.com/)

## Running Locally
Install the software in the above requirements, then execute the following commands:
```sh
  git clone https://github.com/dmayala/nodechat.git
  cd nodechat
  npm install
  foreman start
``` 
The application will run on http://localhost:5000

## Deploying to Heroku
Install the software in the above requirements, then execute the following commands:

```sh
  git clone https://github.com/dmayala/nodechat.git
  cd nodechat
  heroku login
  heroku create
  git push heroku master
  heroku open
``` 

The postinstall script in ```package.json``` will automatically install all client dependencies listed in ```bower.json``` and then run ```gulp build``` to build the Marionette application.

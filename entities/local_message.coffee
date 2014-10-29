_ = require 'underscore'
mongoose = require 'mongoose'

messagesRepo = []

class Message
  constructor: (options = {}) ->
    @id = mongoose.Types.ObjectId().toString()
    @timestamp = options.timestamp
    @author = options.author
    @avatar = options.avatar
    @text = options.text

MessagesAPI =
  createMessage: (options = {}, cb) -> 
    message = new Message options
    messagesRepo.push message
    cb null, message

  getMessages: (cb) -> cb null, messagesRepo

  getMessage: (id, cb) -> cb null, _.findWhere messagesRepo, id: id

  updateMessage: (id, options = {}, cb) ->
    @getMessage id, (err, message) ->
      cb(null, _.extend message, options) unless err

  deleteMessage: (id, cb) -> 
    @getMessage id, (err, message) ->
      messagesRepo.splice(_.indexOf(messagesRepo, message), 1) unless err
      cb null, null


module.exports = MessagesAPI

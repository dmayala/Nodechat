mongoose = require mongoose
Schema = mongoose.Schema

# Schema
MessageSchema = new Schema
  'author': String
  'text': String

# Model
MessageModel = mongoose.model 'Message', MessageSchema

# Entity
class MessageEntity
  getMessages: (callback) ->
    MessageModel.find().exec callback

  getMessage: (id, callback) ->
    MessageModel.findById id, callback

  saveMessage: (message, callback) ->
    MessageModel.create message, callback

module.exports = MessageEntity
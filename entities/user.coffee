mongoose = require 'mongoose'
Schema = mongoose.Schema

# Schema
UserSchema = new Schema name: String

# Model
UserModel = mongoose.model 'User', UserSchema

# Entity
class UserEntity
  getUsers: (callback) ->
    UserModel.find().exec callback

module.exports = UserEntity

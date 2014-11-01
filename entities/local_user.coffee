_ = require 'underscore'
mongoose = require 'mongoose'
AvatarsIO = require 'avatars.io'

AvatarsIO.appId = process.env.APP_ID
AvatarsIO.accessToken = process.env.ACCESS_TOKEN

usersRepo = []
reservedNames = ['SERVER']

isNameTaken = (name) -> 
  _.indexOf(reservedNames, name) > -1 or _.findWhere(usersRepo, nickname: name)

# randomly generate names
createXNames = (x) ->
    candidate = "Guest#{Math.floor(Math.random() * (x - 1) + 1)}"
    # rerun createXNames if name already taken
    if isNameTaken(candidate) then createXNames(x) else candidate

class User
  constructor: (options = {}) ->
    @id = mongoose.Types.ObjectId().toString()
    @nickname = options.nickname or createXNames(10000)
    @status = options.status or true
    @avatar = AvatarsIO.auto @nickname

UserAPI =
  createUser: (options = {}, cb) -> 
    user = new User options
    usersRepo.push user
    cb null, user

  getUsers: (cb) -> cb null, usersRepo

  getUser: (id, cb) -> cb null, _.findWhere usersRepo, id: id

  updateUser: (id, options = {}, cb) ->
    @getUser id, (err, user) ->

      if options.nickname && isNameTaken options.nickname
        return cb null, user

      options.avatar or= user.avatar
        
      cb(null, _.extend user, options) unless err

  deleteUser: (id, cb) -> 
    @getUser id, (err, user) ->
      usersRepo.splice(_.indexOf(usersRepo, user), 1) unless err
      cb null, null

  uploadAvatar: (id, image, cb) ->
    AvatarsIO.upload image, AvatarsIO.appId, (err, url) =>
      @updateUser id, { avatar: url }, (err, user) ->
        cb null, user  

module.exports = UserAPI

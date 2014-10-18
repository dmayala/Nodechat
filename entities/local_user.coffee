_ = require 'underscore'
mongoose = require 'mongoose'

usersRepo = []

isNameTaken = (name) -> _.findWhere(usersRepo, nickname: name)

# randomly generate names
createXNames = (x) ->
    candidate = "Guest#{Math.floor(Math.random() * (x - 1) + 1)}"
    # rerun createXNames if name already taken
    if isNameTaken(candidate) then createXNames(x) else candidate

class User
  constructor: (options = {}) ->
    @id = mongoose.Types.ObjectId()
    @nickname = options.nickname or createXNames(10000)

UserAPI =
  createUser: (options = {}) -> 
    user = new User options
    usersRepo.push user
    return user

  getUsers: -> usersRepo

  getUser: (id) ->  _.findWhere usersRepo, id: id

  updateUser: (id, options = {}) ->

    if options.nickname && isNameTaken(options.nickname)
      # return unedited user for now
      return @getUser(id)

    _.extend @getUser(id), options

  deleteUser: (id) -> 
    usersRepo.splice _.indexOf(usersRepo, @getUser(id)), 1
    return null

module.exports = UserAPI

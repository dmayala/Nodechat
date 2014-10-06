Backbone.LocalStorage = require 'backbone.localStorage'

keyStore = []

findStorageKey = (entity) ->
  return _.result(entity, 'urlRoot') if entity.urlRoot
  return _.result(entity, 'url') if entity.url
  return _.result(entity.collection, 'url') if entity.collection && entity.collection.url
  throw new Error 'unable to determine storage key'

StorageMixin = (entityPrototype) ->
  storageKey = findStorageKey entityPrototype
  localStorage = _.find keyStore, (data) -> data.name is storageKey
  unless localStorage
    localStorage = new Backbone.LocalStorage storageKey
    keyStore.push localStorage
  return localStorage: localStorage

configureStorage = (entity) ->
  _.extend entity.prototype, new StorageMixin entity.prototype

module.exports = configureStorage

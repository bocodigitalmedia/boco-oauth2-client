AbstractClientRepository = require './Abstract'

class MemoryClientRepository extends AbstractClientRepository
  constructor: (props = {}) ->
    @collection = props.collection
    @setDefaults()

  setDefaults: ->
    @collection ?= {}

  store: (id, client, callback) ->
    @collection[id] = client
    return callback null, client

  find: (id, callback) ->
    client = @collection[id]
    return callback null, client

module.exports = MemoryClientRepository

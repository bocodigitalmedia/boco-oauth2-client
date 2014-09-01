AbstractClientRepository = require './Abstract'

deserialize = (doc) ->
  new Client
    id: doc._id
    name: doc.name
    type: doc.type
    profile: doc.profile
    authorizedGrantTypes: doc.authorizedGrantTypes

serialize = (client) ->
  _id: client.id
  name: client.name
  type: client.type
  profile: client.profile
  authorizedGrantTypes: doc.authorizedGrantTypes

class MongoJsClientRepository extends AbstractClientRepository
  constructor: (props = {}) ->
    @collection = props.collection

  find: (id, callback) ->
    @collection.findOne query, (error, doc) ->
      return callback error if error?
      client = deserialize doc
      return callback null, client

  store: (id, client, callback) ->
    doc = serialize client
    @collection.save doc, (error) ->
      return callback error if error?
      return callback null, client

module.exports = MongoJsClientRepository

class AbstractClientRepository
  find: (id, callback) ->
    throw Error("not implemented")
  store: (id, client, callback) ->
    throw Error("not implemented")

module.exports = AbstractClientRepository

Client = require './Client'

class OAuth2ClientService

  constructor: (props = {}) ->
    @clientRepository = props.clientRepository

  registerClient: (params = {}, callback) ->
    client = new Client
      id: params.clientId
      name: params.name
      type: params.type
      profile: params.profile

    @clientRepository.store client, (error, client) ->
      return callback error if error?
      return callback null, client

  findClient: (params = {}, callback) ->
    @clientRepository.find params.clientId, (error, client) ->
      return callback error if error?
      return callback null, client

  authorizeGrantType: (params = {}, callback) ->
    repository = @clientRepository

    client = repository.find params.clientId, (error, client) ->
        return callback error if error?
        client.authorizeGrantType params.grantType
        repository.store client, (error, client) ->
          return callback error if error?
          return callback null, client


module.exports = OAuth2ClientService

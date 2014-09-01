class OAuth2Client
  constructor: (props = {}) ->
    @id = props.id
    @name = props.name
    @type = props.type
    @profile = props.profile
    @authorizedGrantTypes = props.authorizedGrantTypes
    @setDefaults()

  setDefaults: ->
    @authorizedGrantTypes ?= []

  isGrantTypeAuthorized: (grantType) ->
    @authorizedGrantTypes.indexOf(grantType) isnt -1

  authorizeGrantType: (grantType) ->
    return this if @isGrantTypeAuthorized grantType
    @authorizedGrantTypes.push grantType
    return this


module.exports = OAuth2Client

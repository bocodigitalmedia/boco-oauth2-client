class OAuth2Client
  constructor: (props = {}) ->
    @id = props.id
    @name = props.name
    @type = props.type
    @profile = props.profile
    @grantTypes = props.grantTypes
    @setDefaults()

  setDefaults: ->
    @grantTypes ?= []

  isGrantTypeAuthorized: (grantType) ->
    @grantTypes.indexOf(grantType) isnt -1

  authorizeGrantType: (grantType) ->
    @grantTypes.push grantType unless @isGrantTypeAuthorized grantType
    return undefined

module.exports = OAuth2Client

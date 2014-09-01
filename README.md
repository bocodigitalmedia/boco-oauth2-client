# boco-oauth2-client

OAuth2 client service

    BocoOAuth2Client = require 'boco-oauth2-client'
    assert = require 'assert'

The following code supports the async steps that can be run at the end of this README.

    Async = require 'async'
    steps = []
    step = (name, fn) ->
      steps.push name: name, fn: fn

## configuration

    config = {}

### config.clientRepository

The client service needs a simple repository for storing and retrieving clients. We can mock one out using a 'MemoryRepository' that responds to the same interface.

    class MemoryRepository

      constructor: ->
        @collection = {}

      find: (id, callback) ->
        object = @collection[id]
        return callback null, object

      store: (object, callback) ->
        object.id ?= require('uuid').v4()
        @collection[object.id] = object
        return callback null, object

Now we can assign it to the configuration object.

    config.clientRepository = new MemoryRepository()

## Creating a service

Create a client service using the configuration object.

    clientService = BocoOAuth2Client.createService config

## registering a client

    step "registering a client", (done) ->

Register a client by passing in the following parameters:

      params =
        clientId: "d5c530e1-80cb-417d-991b-ef483359672b"
        name: "Endeavor OAuth2 Client"
        type: "confidential"
        profile: "native"

      clientService.registerClient params, done

## authorizing grant types

    step "authorizing grant types", (done) ->

Authorize a client to use the given grant type:

      params =
        clientId: "d5c530e1-80cb-417d-991b-ef483359672b"
        grantType: "password"

      clientService.authorizeGrantType params, done

## Finding a client

    step "finding a client", (done) ->

Find a client with the given id:

      params =
        clientId: "d5c530e1-80cb-417d-991b-ef483359672b"

      clientService.findClient params, (error, client) ->
        return done error if error?

        assert.equal "d5c530e1-80cb-417d-991b-ef483359672b", client.id
        assert.equal "Endeavor OAuth2 Client", client.name
        assert.equal "confidential", client.type
        assert.equal "native", client.profile

        assert.equal false, client.isGrantTypeAuthorized("refresh_token")
        assert.equal true, client.isGrantTypeAuthorized("password")
        done()

---
<br><br><br><br><br>
_Run all the async steps in this README_

    tests = steps.map (step) -> step.fn

    Async.series tests, (error, done) ->
      if error
        console.error error
        process.exit 1
      else
        process.exit 0

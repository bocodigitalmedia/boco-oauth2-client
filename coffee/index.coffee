exports.ClientRepository = require './ClientRepository'
exports.Client = require './Client'
exports.Service = require './Service'

exports.createService = (config) ->
  new exports.Service config

mongoose = require("mongoose")
schemas = require("./schemas")

models = {}

Object.keys(schemas).forEach (name) ->
  models[name] = mongoose.model(name, schemas[name])

module.exports = models
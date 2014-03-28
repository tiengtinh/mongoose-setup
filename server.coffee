express = require("express")
mongoose = require("mongoose")

connectMongo = (callback) ->
  mongoUrl = "mongodb://localhost/samplesetup"
  mongoose.connect mongoUrl
  mongoose.connection.on "open", ->
    console.log "connected to ", mongoUrl
    callback()


app = express()
app.use express.bodyParser()
routes = (app) ->
  app.get "/hello", (req, res) ->
    res.send "Hello Node"


routes app
port = process.env.PORT or 3000
connectMongo ->
  app.listen port, ->
    console.log "Listening on localhost:" + port + "\nPress CTRL-C to stop server."
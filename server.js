var express  = require('express'),
    mongoose = require('mongoose');

var app = express();

app.use(express.bodyParser());

var routes = function(app) {
  
  app.get('/hello', function(req, res) {
    res.send('Hello Node');
  });
  
};

routes(app);

function connectMongo(callback) {
  mongoose.connect('mongodb://localhost/samplesetup');
  mongoose.connection.on('open', function() {
    callback();
  });
}

var port = process.env.PORT || 3000;

connectMongo(function() {
  app.listen(port, function() {
    console.log("Listening on localhost:" + port + "\nPress CTRL-C to stop server.");
  });
});

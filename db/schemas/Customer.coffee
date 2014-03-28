mongoose = require("mongoose")

module.exports = new mongoose.Schema(

  name: String
  address: String
  city: String
  country: String
  phone: String
  balance: Number

)
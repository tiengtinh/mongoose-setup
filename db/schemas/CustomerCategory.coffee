mongoose = require("mongoose")

module.exports = new mongoose.Schema(

  category: String,
  count: Number,
  currentQtrTotal: Number,
  priorQtrTotal: Number

)
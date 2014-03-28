mongoose   = require("mongoose")
_          = require("underscore")
async      = require("async")

models     = require './models'
generators = require './generators'

NUM_COMPANIES = 100
NUM_PRODUCTS  = 1000
NUM_SALES     = 10000

run = ->

  mongoUrl = "mongodb://localhost/samplesetup"

  mongoose.set 'debug', true

  mongoose.connect mongoUrl
  connection = mongoose.connection

  connection.on 'error', console.error.bind(console, 'connection error:')
  connection.once 'open', seed

seed = ->
  db = mongoose.connection.db

  async.waterfall([
    (callback) -> db.dropDatabase callback
    generateCompanies NUM_COMPANIES
    generateProducts NUM_PRODUCTS
    generateSales NUM_SALES
  ]
  (err, results) ->
    if err then console.log 'Fail to seed DB'
    mongoose.disconnect()
  )

generateCompanies = (count) ->
  generateCompany = generators.Company()

  (__ignore, callback) ->
    createFns = _.range(count).map ->
      company = generateCompany()
      models.Company.create.bind models.Company, company
    async.parallel createFns, callback

generateProducts = (count) ->
  generateProduct = generators.Product()

  (companies, callback) ->
    companyIds = companies.map (c) -> c.id
    createFns = _.range(count).map ->
      product = generateProduct(companyIds)
      models.Product.create.bind models.Product, product
    async.parallel createFns, callback

generateSales = (count) ->
  generateSale = generators.Sale()

  (products, callback) ->
    productIds = products.map (c) -> c.id
    createFns = _.range(count).map ->
      sale = generateSale(productIds)
      models.Sale.create.bind models.Sale, sale
    async.parallel createFns, callback

if require.main is module then run()
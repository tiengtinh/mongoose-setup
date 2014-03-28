ch = require('charlatan')
moment = require('moment')

colors = ['blue', 'red', 'yellow', 'green']

module.exports =

  Product: ->

    categories =
      'Music': ['DVD', 'CD', 'iPod', 'Cable']
      'Electronics': ['TV', 'Laptop']
      'Home': ['Table', 'Chair', 'Bed']
    categoryNames = Object.keys(categories)

    (companyIds) ->
      category = ch.Helpers.sample(categoryNames)
      type = ch.Helpers.sample(categories[category])

      return {
        name: type + ch.numerify(' - ###')
        description: ch.Lorem.paragraphs(2)
        manufacturer: ch.Helpers.sample(companyIds)

        color: ch.Helpers.sample(colors)
        releaseDate: moment().subtract('months', ch.Helpers.rand(12)).toDate()
        price: ch.Helpers.rand(500, 20)

        category: category
        model: ch.numerify(ch.letterify('Model-?##?'))
        rating: 1 + ch.Helpers.rand(5)
        reviews: ch.Helpers.rand(100)

      }

  Company: ->
    ->
      sectors = 'Technology Energy Research Finance'.split(' ')
      
      return {
        name: ch.Company.name()
        sector: ch.Helpers.sample(sectors)
        location:
          city: ch.Address.city()
          country: ch.Address.country()
        founded: moment().subtract('years', ch.Helpers.rand(20)).toDate()
      }

  Sale: ->
    (productIds) ->
      return {
        product: ch.Helpers.sample(productIds)
        quantity: ch.Helpers.rand(100)
        saleDate: moment().subtract('days', ch.Helpers.rand(90)).toDate()
        color: ch.Helpers.sample(colors)
      }
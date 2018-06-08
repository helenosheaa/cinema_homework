require('pry')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

film1 = Film.new({
  'title' => 'Titanic',
  'price' => 8
  })
film1.save()

customer1 = Customer.new({
  'name' => 'Helen',
  'funds' => 25
  })
customer1.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id(),
  'film_id' => film1.id()
  })

  binding.pry
  nil

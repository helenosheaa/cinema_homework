require('pry')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

film1 = Film.new({
  'title' => '',
  'price' => 8
  })

customer1 = Customer.new({
  'name' => '',
  'funds' => 25
  })

ticket1 = Ticket.new({
  'customer_id' => customer1.id(),
  'film_id' => film1.id()
  })




  binding.pry
  nil

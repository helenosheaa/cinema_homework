require('pry')
require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')
require_relative('../models/screenings')

# Screening.delete_all()
Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

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
ticket1.save()

screening1 = Screening.new({
  'title' => 'Titanic',
  'showing_time' => '21:00',
  'tickets' => 30
  })
screening1.save()

  binding.pry
  nil

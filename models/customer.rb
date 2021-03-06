require_relative('../db/sql_runner.rb')
require_relative('./film.rb')
require_relative('./ticket.rb')


class Customer

attr_reader(:id)
attr_accessor(:name, :funds)

def initialize (options)
  @id = options['id'].to_i() if options ['id']
  @name = options['name']
  @funds =  options['funds'].to_i()
end

def save ()
  sql = "INSERT INTO customers (name, funds)
  VALUES ($1, $2)
  RETURNING id"
  values = [@name, @funds]
  results = SqlRunner.run(sql, values)
  @id = results[0]['id'].to_i()
end

def update()
  sql = "UPDATE customers SET (name, funds)
  = ($1, $2) WHERE id = $3"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM customers WHERE id= $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def films()
  sql = "SELECT films.*
  FROM films
  INNER JOIN tickets
  ON tickets.film_id = films.id
  WHERE customer_id = $1"
  values = [@id]
  film_data = SqlRunner.run(sql, values)
  return Film.map_items(film_data)
end

def buy_ticket(film)
  Ticket.new({'customer_id' => @id, 'film_id' => film.id}).save()
  @funds -= film.price
  update()
  #PASS IN FILM
  #CREATE NEW TICKET WITH FILM_ID AND @ID
  #SAVE TICKET .save
  #REDUCE FUNDS BY FILM.PRICE
  #UPDATE CUSTOMER
end

def customer_tickets_bought()
  sql = "SELECT * FROM tickets WHERE tickets.customer_id = $1"
  values = [@id]
  bought = SqlRunner.run(sql, values)
  tickets_array = Ticket.map_items(bought)
  return tickets_array.length
end

def self.all()
  sql = "SELECT * FROM customers"
  customers = SqlRunner.run(sql)
  return customers.map {|customer| Customer.new(customer)}
end

def self.delete_all()
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end

def self.map_items(customer_data)
  result = customer_data.map { |customer| Customer.new( customer ) }
  return result
end

end

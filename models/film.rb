require_relative('../db/sql_runner.rb')
require_relative('./customer.rb')
require_relative('./ticket.rb')

class Film

attr_reader(:id)
attr_accessor(:title, :price)

def initialize(options)
  @id = options['id'].to_i() if options['id']
  @title = options['title']
  @price = options['price'].to_i()
end

def save ()
  sql = "INSERT INTO films (title, price)
  VALUES ($1, $2)
  RETURNING id"
  values = [@title, @price]
  results = SqlRunner.run(sql, values)
  @id = results[0]['id'].to_i()
end

def update()
  sql = "UPDATE films SET (title, price)
  = ($1, $2) WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM films WHERE id= $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def customers()
  sql = "SELECT customers.*
  FROM customers
  INNER JOIN tickets
  ON tickets.customer_id = customers.id
  WHERE film_id = $1"
  values = [@id]
  customer_data = SqlRunner.run(sql, values)
  return Customer.map_items(customer_data)
end

def number_of_viewers()
  sql = "SELECT * FROM tickets WHERE tickets.film_id = $1"
  values = [@id]
  viewers = SqlRunner.run(sql, values)
  viewers_array = Ticket.map_items(viewers)
  return viewers_array.length
end

def self.all()
  sql = "SELECT * FROM films"
  films = SqlRunner.run(sql)
  return films.map {|film| Film.new(film)}
end

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def self.map_items(film_data)
  result = film_data.map { |film| Film.new( film ) }
  return result
end

end

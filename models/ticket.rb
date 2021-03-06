require_relative('../db/sql_runner.rb')
require_relative('./film.rb')
require_relative('./customer.rb')

class Ticket

attr_reader(:id)
attr_accessor(:customer_id, :film_id)

def initialize(options)
  @id = options['id'].to_i() if options['id'].to_i()
  @customer_id = options['customer_id'].to_i()
  @film_id = options['film_id'].to_i()
end

def save ()
  sql = "INSERT INTO tickets (customer_id, film_id)
  VALUES ($1, $2)
  RETURNING id"
  values = [@customer_id, @film_id]
  results = SqlRunner.run(sql, values)
  @id = results[0]['id'].to_i()
end

def update()
  sql = "UPDATE tickets SET (customer_id, film_id)
  = ($1, $2) WHERE id = $3"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM tickets WHERE id= $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM tickets"
  tickets = SqlRunner.run(sql)
  return tickets.map {|ticket| Ticket.new(ticket)}
end

def self.delete_all()
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end

def self.map_items(ticket_data)
  result = ticket_data.map { |ticket| Ticket.new( ticket ) }
  return result
end

end


# Check how many tickets were bought by a customer
#   - Check how many customers are going to watch a certain film

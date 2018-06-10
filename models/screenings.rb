require_relative('../db/sql_runner.rb')
require_relative('./film.rb')
require_relative('./ticket.rb')
require_relative('./customer.rb')

class Screening

attr_reader(:id)
attr_accessor(:title, :showing_time, :tickets)

def initialize (options)
  @id = options['id'].to_i() if options ['id']
  @title = options['title']
  @showing_time =  options['showing_time']
  @tickets = options['tickets'].to_i()
end

def save ()
  sql = "INSERT INTO screenings (title, showing_time, tickets)
  VALUES ($1, $2, $3)
  RETURNING id"
  values = [@title, @showing_time, @tickets]
  results = SqlRunner.run(sql, values)
  @id = results[0]['id'].to_i()
end

def update()
  sql = "UPDATE screenings (title, showing_time, tickets)
  VALUES ($1, $2, $3) WHERE id = $4"
  values = [@title, @showing_time, @tickets]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM screenings WHERE id= $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM screenings"
  screenings = SqlRunner.run(sql)
  return screenings.map {|screening| Screening.new(screening)}
end

def self.delete_all()
  sql = "DELETE FROM screenings"
  SqlRunner.run(sql)
end

def self.map_items(screening_data)
  result = screening_data.map { |screening| Screening.new(screening) }
  return result
end

end

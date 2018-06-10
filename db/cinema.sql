DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS screenings;

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  showing_time VARCHAR(255),
  tickets INT4
);

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT4
);

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT4
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  film_id INT4 REFERENCES films(id),
  customer_id INT4 REFERENCES customers(id)
);

CREATE DATABASE homechekr;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  email VARCHAR(500),
  password_digest VARCHAR(500),
  profile_img TEXT
);


CREATE TABLE properties(
  id SERIAL PRIMARY KEY,
  date_added TIMESTAMP,
  address TEXT,
  street_number TEXT,
  street_name TEXT,
  suburb TEXT,
  state TEXT,
  postcode TEXT,
  property_type TEXT,
  sale_type TEXT,
  listing_url TEXT,
  storey_count INTEGER,
  bed_count INTEGER,
  bath_count INTEGER,
  car_space_count INTEGER,
  asking_price INTEGER,
  sold_price INTEGER,
  cooking TEXT,
  aircon TEXT,
  heating TEXT,
  orientation TEXT,
  notes_general TEXT,
  main_img TEXT,
  user_id INTEGER
);


CREATE TABLE comments(
  id SERIAL PRIMARY KEY,
  property_id INTEGER,
  user_id INTEGER,
  content TEXT
);


-- ALTER TABLE properties
-- ADD COLUMN address text;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS beers CASCADE;
DROP TABLE IF EXISTS wishlists CASCADE;
DROP TABLE IF EXISTS favourites CASCADE;
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS recommendations CASCADE;
DROP TABLE IF EXISTS upvotes CASCADE;
DROP TABLE IF EXISTS ratings CASCADE;
DROP TABLE IF EXISTS search_analytics CASCADE;

CREATE TABLE users(
  id SERIAL PRIMARY KEY NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE beers(
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  brewery VARCHAR(255) NOT NULL,
  beer_image TEXT,
  type VARCHAR(255) NOT NULL,
  abv INTEGER NOT NULL,
  beer_store_id INTEGER
);

CREATE TABLE wishlists(
  id SERIAL PRIMARY KEY NOT NULL,
  beer_id INTEGER REFERENCES beers(id) ON DELETE CASCADE,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE favourites(
  id SERIAL PRIMARY KEY NOT NULL,
  beer_id INTEGER REFERENCES beers(id) ON DELETE CASCADE,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

-- CREATE TABLE ratings(
--   id SERIAL PRIMARY KEY NOT NULL,
--   user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
--   beer_id INTEGER REFERENCES beers(id) ON DELETE CASCADE,
--   rank INTEGER
-- );

CREATE TABLE reviews(
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  beer_id INTEGER REFERENCES beers(id) ON DELETE CASCADE,
  review VARCHAR(255),
  sweet INTEGER,
  sour INTEGER,
  hoppy INTEGER,
  bitter INTEGER,
  rank INTEGER
);

CREATE TABLE upvotes(
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  review_id INTEGER REFERENCES reviews(id) ON DELETE CASCADE
);

CREATE TABLE recommendations(
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  beer_id INTEGER REFERENCES beers(id) ON DELETE CASCADE
);

CREATE TABLE search_analytics(
    id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  beer_id INTEGER REFERENCES beers(id) ON DELETE CASCADE,
  query VARCHAR(255)
);

ALTER TABLE
  users OWNER TO dev;
ALTER TABLE
  beers OWNER TO dev;
ALTER TABLE
  reviews OWNER TO dev;
ALTER TABLE
  upvotes OWNER TO dev;
ALTER TABLE
  wishlists OWNER TO dev;
ALTER TABLE
  favourites OWNER TO dev;
ALTER TABLE
  recommendations OWNER TO dev;
-- ALTER TABLE
--   ratings OWNER TO dev;
ALTER TABLE
  search_analytics OWNER TO dev;
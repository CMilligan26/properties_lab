DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT2,
  number_of_bedrooms INT2,
  build VARCHAR(255)

);

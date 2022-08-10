/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth DATE NOT NULL,
  escape_attempts INTEGER NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

/* Query multiple tables */

CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(20),
  age INTEGER NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE species (
  id INTEGER GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(20),
  PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INTEGER;
ALTER TABLE animals ADD COLUMN owner_id INTEGER;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

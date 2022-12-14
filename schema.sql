/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;


CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

-- Add a column species of type string to the animals
ALTER TABLE animals ADD species VARCHAR(70);

-- Create a table named owners with id, full_name, age.
CREATE TABLE owners(
 id INT GENERATED ALWAYS AS IDENTITY,
 full_name VARCHAR(100),
 age INT,
 PRIMARY KEY(id)
);

-- Create a table named species with id, name 
CREATE TABLE species(
 id INT GENERATED ALWAYS AS IDENTITY,
 name VARCHAR(80),
 PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT
 REFERENCES species(id)
 ON DELETE CASCADE;
 
ALTER TABLE animals ADD COLUMN owner_id INT
 REFERENCES owners(id)
 ON DELETE CASCADE;

 -- Create a table named vets.
CREATE TABLE vets (
	id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(50),
	age INT,
	date_of_graduation DATE
);


/*Create nany-to-many relationship tables*/
CREATE TABLE specializations (
	vets_id INT NOT NULL,
	species_id INT NOT NULL,
	FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE CASCADE,
	FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE,
	PRIMARY KEY (vets_id, species_id)
);

CREATE TABLE visits (
	vets_id INT NOT NULL,
	animals_id INT NOT NULL,
    date_of_visit DATE,
	FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE CASCADE,
	FOREIGN KEY (animals_id) REFERENCES animals (id) ON DELETE CASCADE,
	PRIMARY KEY (vets_id, animals_id, date_of_visit)
);

/* Perfomance audit */
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create indexes

CREATE INDEX animal_id_asc ON visits (animal_id ASC);

CREATE INDEX vet_id_asc ON visits (vet_id ASC);

CREATE INDEX email_asc ON owners (email ASC);





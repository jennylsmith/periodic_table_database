UPDATE properties SET type_id = CASE
  WHEN type = 'metal' THEN 1
  WHEN type = 'metalloid' THEN 2
  WHEN type = 'nonmetal' THEN 3
  END;

UPDATE elements SET symbol = CASE 
  WHEN symbol ~ '^[a-z]' THEN REGEXP_REPLACE(symbol,'^[a-z]',UPPER(SUBSTRING(symbol,1,1)))
  ELSE symbol
  END

-- ALTER TABLE properties ADD COLUMN am NUMERIC; 
-- UPDATE properties SET am = atomic_mass;
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE TEXT;
UPDATE properties SET atomic_mass = CASE 
  WHEN am > 0 THEN TRIM(trailing '0' FROM atomic_mass)
  END;

INSERT INTO elements(atomic_number, name, symbol) 
  VALUES(9, 'Fluorine', 'F'),
  (10,'Neon', 'Ne');

INSERT INTO properties(atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius,type, type_id)
  VALUES(9,'18.998',-220, -188.1, 'nonmetal',3),
  (10,'20.18',-248.6, -246.1, 'nonmetal', 3);




-------- NOTES --------------

-- ALTER TABLE properties ALTER COLUMN am TYPE DECIMAL(6,4) USING am::numeric(6,4);
-- SELECT MAX(LENGTH(am)), MAX(LENGTH(REGEXP_REPLACE(am, '^[0-9]+\.', ''))) FROM properties;
-- SELECT atomic_mass,  REGEXP_RELPACE(am, CONCAT(SUBSTRING((REGEXP_MATCH(am,'[1-9]0{1,}$'))[1],2,LENGTH(am)), "$"), '') FROM properties;
-- SELECT atomic_mass, TRIM(trailing SUBSTRING((REGEXP_MATCH(am,'[1-9]0{1,}$'))[1],2,LENGTH(am)) FROM am ) FROM properties;
-- SELECT atomic_mass, CAST(atomic_mass AS DECIMAL(6,5)) FROM properties 

-- select symbol, CASE 
--   WHEN symbol ~ '^[a-z]' THEN REGEXP_REPLACE(symbol,'^[a-z]',UPPER(SUBSTRING(symbol,1,1)))
--   ELSE symbol
--   END AS sym_cap
-- FROM elements;

-- SELECT symbol,REGEXP_REPLACE(symbol,'^[a-z]',UPPER(SUBSTRING(symbol,1,1))) AS first_letter FROM elements WHERE symbol ~ '^[a-z]' LIMIT 5;
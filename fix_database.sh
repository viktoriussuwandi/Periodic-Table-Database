  # You should rename the weight column to atomic_mass
  RENAME_PROPERTIES_WEIGHT=$($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;")
  echo "RENAME_PROPERTIES_WEIGHT                    : $RENAME_PROPERTIES_WEIGHT"

  # You should rename the melting_point column to melting_point_celsius and the boiling_point column to boiling_point_celsius
  RENAME_PROPERTIES_MELTING_POINT=$($PSQL"ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;")
  RENAME_PROPERTIES_BOILING_POINT=$($PSQL"ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;")
  echo "RENAME_PROPERTIES_MELTING_POINT             : $RENAME_PROPERTIES_MELTING_POINT"
  echo "RENAME_PROPERTIES_BOILING_POINT             : $RENAME_PROPERTIES_BOILING_POINT"

  # Your melting_point_celsius and boiling_point_celsius columns should not accept null values
  ALTER_PROPERTIES_MELTING_POINT_NOT_NULL=$($PSQL"ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;")
  ALTER_PROPERTIES_BOILING_POINT_NOT_NULL=$($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;")
  echo "ALTER_PROPERTIES_MELTING_POINT_NOT_NULL     : $ALTER_PROPERTIES_MELTING_POINT_NOT_NULL"
  echo "ALTER_PROPERTIES_BOILING_POINT_NOT_NULL     : $ALTER_PROPERTIES_BOILING_POINT_NOT_NULL"

  # You should add the UNIQUE constraint to the symbol and name columns from the elements table
  ALTER_ELEMENTS_SYMBOL_UNIQUE=$($PSQL "ALTER TABLE elements ADD UNIQUE(symbol);")
  ALTER_ELEMENTS_NAME_UNIQUE=$($PSQL "ALTER TABLE elements ADD UNIQUE(name);")
  echo "ALTER_ELEMENTS_SYMBOL_UNIQUE                : $ALTER_ELEMENTS_SYMBOL_UNIQUE"
  echo "ALTER_ELEMENTS_NAME_UNIQUE                  : $ALTER_ELEMENTS_NAME_UNIQUE"

  # Your symbol and name columns should have the NOT NULL constraint
  ALTER_ELEMENTS_SYMBOL_NOT_NULL=$($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;")
  ALTER_ELEMENTS_SYMBOL_NOT_NULL=$($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL;")
  echo "ALTER_ELEMENTS_SYMBOL_NOT_NULL              : $ALTER_ELEMENTS_SYMBOL_NOT_NULL"
  echo "ALTER_ELEMENTS_SYMBOL_NOT_NULL              : $ALTER_ELEMENTS_SYMBOL_NOT_NULL"

  # You should set the atomic_number column from the properties table as a foreign key that references the column of the same name in the elements table
  ALTER_PROPERTIES_ATOMIC_NUMBER_FOREIGN_KEY=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);")
  echo "ALTER_PROPERTIES_ATOMIC_NUMBER_FOREIGN_KEY  : $ALTER_PROPERTIES_ATOMIC_NUMBER_FOREIGN_KEY"

  # You should create a types table that will store the three types of elements
  CREATE_TBL_TYPES=$($PSQL "CREATE TABLE types();")
  echo "CREATE_TBL_TYPES                            : $CREATE_TBL_TYPES"

  # Your types table should have a type_id column that is an integer and the primary key
  ADD_COLUMN_TYPES_TYPE_ID=$($PSQL "ALTER TABLE types ADD COLUMN type_id SERIAL PRIMARY KEY;")
  echo "ADD_COLUMN_TYPES_TYPE_ID                    : $ADD_COLUMN_TYPES_TYPE_ID"

  # Your types table should have a type column that's a VARCHAR and cannot be null. It will store the different types from the type column in the properties table
  ADD_COLUMN_TYPES_TYPE=$($PSQL "ALTER TABLE types ADD COLUMN type VARCHAR(20) NOT NULL;")
  echo "ADD_COLUMN_TYPES_TYPE                       : $ADD_COLUMN_TYPES_TYPE"

  # You should add three rows to your types table whose values are the three different types from the properties table
  INSERT_COLUMN_TYPES_TYPE=$($PSQL "INSERT INTO types(type) SELECT DISTINCT(type) FROM properties;")
  echo "INSERT_COLUMN_TYPES_TYPE                    : $INSERT_COLUMN_TYPES_TYPE"

  # Your properties table should have a type_id foreign key column that references the type_id column from the types table. It should be an INT with the NOT NULL constraint
  ADD_COLUMN_PROPERTIES_TYPE_ID=$($PSQL "ALTER TABLE PROPERTIES ADD COLUMN type_id INT;")
  ADD_FOREIGN_KEY_PROPERTIES_TYPE_ID=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id);")
  echo "ADD_COLUMN_PROPERTIES_TYPE_ID               : $ADD_COLUMN_PROPERTIES_TYPE_ID"
  echo "ADD_FOREIGN_KEY_PROPERTIES_TYPE_ID          : $ADD_FOREIGN_KEY_PROPERTIES_TYPE_ID"

  # Each row in your properties table should have a type_id value that links to the correct type from the types table
  UPDATE_PROPERTIES_TYPE_ID=$($PSQL "UPDATE properties SET type_id = (SELECT type_id FROM types WHERE properties.type = types.type);")
  ALTER_COLUMN_PROPERTIES_TYPE_ID_NOT_NULL=$($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;")
  echo "UPDATE_PROPERTIES_TYPE_ID                   : $UPDATE_PROPERTIES_TYPE_ID"
  echo "ALTER_COLUMN_PROPERTIES_TYPE_ID_NOT_NULL    : $ALTER_COLUMN_PROPERTIES_TYPE_ID_NOT_NULL"

  # You should capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others
  UPDATE_ELEMENTS_SYMBOL=$($PSQL "UPDATE elements SET symbol=INITCAP(symbol);")
  echo "UPDATE_ELEMENTS_SYMBOL                      : $UPDATE_ELEMENTS_SYMBOL"

  # You should remove all the trailing zeros after the decimals from each row of the atomic_mass column. You may need to adjust a data type to DECIMAL for this. The final values they should be are in the atomic_mass.txt file
  ALTER_VARCHAR_PROPERTIES_ATOMIC_MASS=$($PSQL "ALTER TABLE PROPERTIES ALTER COLUMN atomic_mass TYPE VARCHAR(9);")
  UPDATE_FLOAT_PROPERTIES_ATOMIC_MASS=$($PSQL"UPDATE properties SET atomic_mass=CAST(atomic_mass AS FLOAT);")
  echo "ALTER_VARCHAR_PROPERTIES_ATOMIC_MASS        : $ALTER_VARCHAR_PROPERTIES_ATOMIC_MASS"
  echo "UPDATE_FLOAT_PROPERTIES_ATOMIC_MASS         : $UPDATE_FLOAT_PROPERTIES_ATOMIC_MASS"

 # You should add the element with atomic number 9 to your database. Its name is Fluorine, symbol is F, mass is 18.998, melting point is -220, boiling point is -188.1, and it's a nonmetal
  INSERT_ELEMENT_F=$($PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES(9,'F','Fluorine');")
  INSERT_PROPERTIES_F=$($PSQL "INSERT INTO properties(atomic_number,type,melting_point_celsius,boiling_point_celsius,type_id,atomic_mass) VALUES(9,'nonmetal',-220,-188.1,3,'18.998');")
  echo "INSERT_ELEMENT_F                            : $INSERT_ELEMENT_F"
  echo "INSERT_PROPERTIES_F                         : $INSERT_PROPERTIES_F"

  # You should add the element with atomic number 10 to your database. Its name is Neon, symbol is Ne, mass is 20.18, melting point is -248.6, boiling point is -246.1, and it's a nonmetal
  INSERT_ELEMENT_NE=$($PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES(10,'Ne','Neon');")
  INSERT_PROPERTIES_NE=$($PSQL "INSERT INTO properties(atomic_number,type,melting_point_celsius,boiling_point_celsius,type_id,atomic_mass) VALUES(10,'nonmetal',-248.6,-246.1,3,'20.18');")
  echo "INSERT_ELEMENT_NE                           : $INSERT_ELEMENT_NE"
  echo "INSERT_PROPERTIES_NE                        : $INSERT_PROPERTIES_NE"

  # You should delete the non existent element, whose atomic_number is 1000, from the two tables
  DELETE_PROPERTIES_1000=$($PSQL "DELETE FROM properties WHERE atomic_number=1000;")
  DELETE_ELEMENTS_1000=$($PSQL "DELETE FROM elements WHERE atomic_number=1000;")
  echo "DELETE_PROPERTIES_1000                      : $DELETE_PROPERTIES_1000"
  echo "DELETE_ELEMENTS_1000                        : $DELETE_ELEMENTS_1000"
  
  # Your properties table should not have a type column
  DELETE_COLUMN_PROPERTIES_TYPE=$($PSQL "ALTER TABLE properties DROP COLUMN type;")
  echo "DELETE_COLUMN_PROPERTIES_TYPE               : $DELETE_COLUMN_PROPERTIES_TYPE"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #FAILED ALTERNATIVES
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  # You should remove all the trailing zeros after the decimals from each row of the atomic_mass column. You may need to adjust a data type to DECIMAL for this. The final values they should be are in the atomic_mass.txt file
  # ADD_COLUMN_PROPERTIES_WEIGHT=$($PSQL "ALTER TABLE properties ADD COLUMN weight FLOAT;")
  # UPDATE_COLUMN_PROPERTIES_WEIGHT=$($PSQL "UPDATE properties SET weight=atomic_mass;")
  # RENAME_COLUMN_PROPERTIES_ATOMIC_MAS=$($PSQL "ALTER TABLE properties RENAME COLUMN atomic_mass TO tempcol")
  # RENAME_COLUMN_PROPERTIES_ATOMIC_MASS=$($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;")
  # SET_NOT_NULL_PROPERTIES_ATOMIC_MASS=$($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass SET NOT NULL;")
  # ALTER_VARCHAR_PROPERTIES_TEMPCOL=$($PSQL "ALTER TABLE properties ALTER COLUMN tempcol TYPE VARCHAR(20);")
  # DROP_CONSTRAINT_PROPERTIES_TEMPCOL=$($PSQL "ALTER TABLE properties ALTER COLUMN tempcol DROP NOT NULL;")
  # DROP_COLUMN_PROPERTIES_TEMPCOL= $($PSQL "ALTER TABLE properties DROP COLUMN tempcol;")

  # echo "ADD_COLUMN_PROPERTIES_WEIGHT                : $ADD_COLUMN_PROPERTIES_WEIGHT"
  # echo "UPDATE_COLUMN_PROPERTIES_WEIGHT             : $UPDATE_COLUMN_PROPERTIES_WEIGHT"
  # echo "RENAME_COLUMN_PROPERTIES_ATOMIC_MAS         : $RENAME_COLUMN_PROPERTIES_ATOMIC_MAS"
  # echo "RENAME_COLUMN_PROPERTIES_ATOMIC_MASS        : $RENAME_COLUMN_PROPERTIES_ATOMIC_MASS"
  # echo "SET_NOT_NULL_PROPERTIES_ATOMIC_MASS         : $SET_NOT_NULL_PROPERTIES_ATOMIC_MASS"
  # echo "ALTER_VARCHAR_PROPERTIES_TEMPCOL            : $ALTER_VARCHAR_PROPERTIES_TEMPCOL"
  # echo "DROP_CONSTRAINT_PROPERTIES_TEMPCOL          : $DROP_CONSTRAINT_PROPERTIES_TEMPCOL"
  # echo "DROP_COLUMN_PROPERTIES_TEMPCOL              : $DROP_COLUMN_PROPERTIES_TEMPCOL"
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
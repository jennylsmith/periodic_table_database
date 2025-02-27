#!/bin/bash 

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# ./element.sh 1
# ./element.sh H
# ./element.sh Hydrogen
# output: The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

if [[ $1 ]]
then
  ELEMENT=$1

  if [[ "$ELEMENT" =~ ^[0-9] ]]
  then
    CONDITION="atomic_number = $ELEMENT"
  elif [[ "$ELEMENT" =~ ^[A-Z][a-z]?$ ]]
  then
    CONDITION="symbol = '$ELEMENT' "
  else
    CONDITION="name = '$ELEMENT' "
  fi
  # echo $CONDITION
  QUERY=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $CONDITION;")
  # echo $QUERY

  if [[ -z $QUERY ]]
  then 
    echo "I could not find that element in the database."
  else
    echo $QUERY | tr '|' ' ' | while read NUM NAME SYM TYPE MASS MP BP
    do
      echo -e "The element with atomic number $NUM is $NAME ($SYM). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
    done
  fi
 
 else
  echo -e "Please provide an element as an argument."

fi


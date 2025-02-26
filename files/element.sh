#!/bin/bash 

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

echo -e "\nPlease provide an element as an argument.\n"

# ./element.sh 1
# ./element.sh H
# ./element.sh Hydrogen
# output: The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
#!/bin/bash

#while loop example
COUNT=1

echo "=== WHILE LOOP ==="

while [ "$COUNT" -le 3 ]
do
	echo "Checking server: $COUNT"
	COUNT=$((COUNT + 1))
done

# Until loop example
COUNT=1

echo "=== UNTIL LOOP ==="

until [ "$COUNT" -gt 3 ]
do
	echo "Checking server: $COUNT"
	COUNT=$((COUNT + 1))
done

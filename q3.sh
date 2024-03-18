#!/bin/bash
#q3.sh


#asks the user to enter a 5-letter word. It checks if the entered word is exactly 5 alphabetic characters. If not, it prompts the user again.

while :; do
	read -p "Enter a 5-letter word: " input_word
		if [[ $input_word =~ ^[a-zA-Z]{5}$ ]]; then
			break
		else
			echo "The word must be exactly 5 alphabetic characters."
		fi
done



#asks the user to enter a 5 character consisting of G, Y, and S. It validates that the pattern is exactly 5 characters long. If not, it prompts the user again.

while :; do
	read -p "Enter a 5-character color pattern (G/Y/S): " pattern
		if [[ $pattern =~ ^[GYS]{5}$ ]]; then
			break
		else
			echo "The pattern must be exactly 5 characters - (G/Y/S) ."
		fi
done



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

#compares a word against an input word using a given 'G', 'Y', 'S' pattern, where 'G' means the letters must match exactly, 'Y' means the letter exists elsewhere in the word, and 'S' means the letter shouldn't exist in the word. Returns 0 for a match, 1 otherwise. Both word and input word are compared in a case-insensitive manner.

match_pattern() {
	word=${1,,} #for handling case-sensitive
	input_word=${2,,} #for handling case-sensitive
	pattern=$3    
	
	for (( i=0; i<${#word}; i++ )); do
		letter="${word:$i:1}"
		input_letter="${input_word:$i:1}"
		pattern_letter="${pattern:$i:1}"
	
		if [[ "$pattern_letter" == "G" ]]; then
			if [[ "$letter" != "$input_letter" ]]; then
				return 1
			fi
		elif [[ "$pattern_letter" == "Y" ]]; then 
    			if [[ "$letter" == "$input_letter" ]]; then
        			return 1
   		 	elif ! [[ "$word" =~ "$input_letter" ]]; then
   		 		return 1
			fi
		elif [[ "$pattern_letter" == "S" ]]; then
			if [[ "$word" =~ "$input_letter" ]]; then
				return 1
			fi
		fi
	done
	
	return 0
}

match_pattern "hello" "hello" "GGGGG"
echo "$?"

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
   		 	elif  ! [[ "$word" =~ "$input_letter" ]]; then 
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

# This loop reads through each line (word) in the 'words.txt' file. 
# For each word, it first checks if the word is exactly 5 letters long and contains only alphabetic characters.
# If the word meets these criteria, it then calls the 'match_pattern' function with the word, the user-input word, and the pattern.
# If 'match_pattern' returns true (indicating a match according to the pattern), the word is printed.

while read -r word; do
    if [[ ${#word} -eq 5 && $word =~ ^[a-zA-Z]+$ ]]; then
        if match_pattern "$word" "$input_word" "$pattern"; then
            echo "$word"
        fi
    fi
done < words.txt

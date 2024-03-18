#!/bin/bash
#q3.sh


#asks the user to enter a 5-letter word. It checks if the entered word is exactly 5 alphabetic characters. If not, it prompts the user again.

#while :; do
#	read -p "Enter a 5-letter word: " input_word
#		if [[ $input_word =~ ^[a-zA-Z]{5}$ ]]; then
#			break
#		else
#			echo "The word must be exactly 5 alphabetic characters."
#		fi
#done



#asks the user to enter a 5 character consisting of G, Y, and S. It validates that the pattern is exactly 5 characters long. If not, it prompts the user again.

#while :; do
#	read -p "Enter a 5-character color pattern (G/Y/S): " pattern
#		if [[ $pattern =~ ^[GYS]{5}$ ]]; then
#			break
#		else
#			echo "The pattern must be exactly 5 characters - (G/Y/S) ."
#		fi
#done

#compares a word against an input word using a given 'G', 'Y', 'S' pattern, where 'G' means the letters must match exactly, 'Y' means the letter exists elsewhere in the word, and 'S' means the letter shouldn't exist in the word. Returns 0 for a match, 1 otherwise. Both word and input word are compared in a case-insensitive manner.

match_pattern() {
	word=${1,,} #for handling case-sensitive
	input_word=${2,,} #for handling case-sensitive
	pattern=$3    
	
	for (( i=0; i<${#word}; i++ )); do
		letter="${word:$i:1}"
		input_letter="${input_word:$i:1}"
		pattern_letter="${pattern:$i:1}"
		
		 echo "Debug, Checking letter $i -> $letter : $input_letter with pattern $pattern_letter"

		
		if [[ "$pattern_letter" == "G" ]]; then
			if [[ "$letter" != "$input_letter" ]]; then
				echo "Failed at G: $letter != $input_letter"
				return 1
			fi
		elif [[ "$pattern_letter" == "Y" ]]; then 
    			if [[ "$letter" == "$input_letter" ]]; then
    				echo "Failed at Y: $letter == $input_letter"
        			return 1
   		 	elif  [[ "$word" =~ "$input_letter" ]]; then
   		 		echo "Failed at Y: $word does not contain $input_letter"
   		 		return 1
			fi
		elif [[ "$pattern_letter" == "S" ]]; then
			if [[ "$word" =~ "$input_letter" ]]; then
			        echo "Failed at S: $word contains $input_letter"
				return 1
			fi
		fi
	done
	
	return 0
}

#We built a function that will help us to test the logic of match_pattern function and all its edge cases
test_pattern() {
    local word=$1
    local input_word=$2
    local pattern=$3
    local expected_result=$4
    local test_description=$5

    match_pattern "$word" "$input_word" "$pattern"
    local result=$?

    if [[ $result -eq $expected_result ]]; then
        echo -e "Pass: $test_description\n"
    else
        echo -e "Fail: $test_description\n"
    fi
}

#We asked CHAT-GPT to generate test scenarios that check all the edge cases, for a comprehensive QA on our function's logic

test_pattern "hello" "hello" "GGGGG" 0 "Exact match"
test_pattern "world" "hello" "SSSSS" 1 "Complete mismatch"
test_pattern "heloo" "hello" "GGGSS" 1 "Partial match with G and S"
test_pattern "fghij" "abcde" "YYYYY" 1 "All Y but letters don’t exist in the word"
test_pattern "lleho" "hello" "SGYGS" 1 "Repetitive characters, different pattern"
test_pattern "llskt" "hello" "SSYYS" 0 "Correct letter in wrong position"
test_pattern "rosld" "world" "SGYGG" 0 "Mixed pattern with correct matches"
test_pattern "ppale" "apple" "YSSSS" 1 "'Y' pattern with incorrect letter"
test_pattern "tabcd" "abcde" "YYYYS" 0 "Multiple 'Y' in correct position"

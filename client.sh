#!/usr/bin/bash

if command -v figlet &> /dev/null; then
    echo "Welcome to"
    figlet "wordle-helper" 
else
    echo "Welcome to wordle-helper"
fi

members=()
nonmembers=()

while true; do
    echo "Guess the word and enter the results here."
    echo "Use '*' for unknown letters"
    echo ""

    while true; do
        read input
        if [ ${#input} -ne 5 ]; then
            echo "The string must have length of 5 characters."
            continue
        fi
        echo ""
        echo "You entered: \"$input\""
        echo ""
        break
    done
    
    
    base_regex=""
    for (( i=0; i<${#input}; i++ )); do
        current="${input:$i:1}"
    
        if [[ "$current" == "*" ]]; then
            base_regex+='\w'
        else
            base_regex+="$current"
        fi
    done
    
    
    echo "Enter characters known to be in the word."
    echo ""
    
    while true; do
        echo "Add a character or type 'next' to continue."
        echo ""
        read input
        char="${input,,}"
        case $char in
    	    next)
    		echo ""
    		break;;
    	    [a-z])
                echo ""
                members+=($char)
    		;;
            *)
                echo "Input must be a single character, or 'next'"
    		echo ""
    		;;
        esac
    done
    
    
    if [[ ${#members[@]} -gt 0 ]]; then
        echo "Member characters:"
        echo "${members[@]}"
        echo ""
    fi
    
    echo "Enter characters known to NOT be in the word"
    echo ""
    while true; do
        echo "Add a character. Type 'next' to continue."
        echo ""
        read input
        char="${input,,}"
        case $char in
    	    next)
    		echo ""
    		break;;
    	    [a-z])
                echo ""
                nonmembers+=($char)
    		;;
            *)
                echo "Input must be a single letter or 'next'"
                echo ""
    		;;
        esac
    done
    
    
    if [[ ${#nonmembers[@]} -gt 0 ]]; then
        echo "Non-member characters:"
        echo "${nonmembers[@]}"
        echo ""
    fi
    
    
    # Build the chained grep command dynamically
    input_file="words.txt"
    command="grep '$base_regex' $input_file"
    
    if [[ ${#nonmembers[@]} -gt 0 ]]; then
        # Create pattern from array
        pattern="[${nonmembers[*]}]"
    
        # Remove spaces
        pattern="${pattern// /}"
    
        command+=" | grep -v '$pattern'"
    fi
    
    if [[ ${#members[@]} -gt 0 ]]; then
	pattern="^"

        for member in "${members[@]}"; do
            pattern+="(?=.*$member)"
	done

	pattern+=".*"
        command+=" | grep -P '$pattern'"
 
    fi
    
    command+=" | head | cut -f 1"
    
    echo "Command is:"
    echo $command

    # Execute the command
    echo ""
    echo "Running command..."
    echo ""

    word_count=$(eval $command | wc -l)

    if [[ $word_count -lt 1 ]]; then
	echo "No matching words found. Try again, or open a GitHub issue to suggest a new word."
	echo ""
        exit 1
    fi

    echo "Next best guess(es):"
    eval $command

    echo ""

done


echo "Best guess is:"
head -n 1 words_ordered_by_path_sum.txt | cut -f 1

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
    
    
    echo "Member characters:"
    echo "${members[@]}"
    echo ""
    
    echo "Enter characters known to NOT be in the word"
    echo ""
    while true; do
        echo "Add a character. Type 'next' to continue."
        read input
        char="${input,,}"
        case $char in
    	    next)
    		echo ""
    		break;;
    	    [a-z])
                    echo "Character is: $char"
    		echo ""
                    nonmembers+=($char)
    		;;
                *)
                    echo "Input must be a single character, or 'next'"
    		echo ""
    		;;
        esac
    done
    
    
    echo "Non-member characters:"
    echo "${nonmembers[@]}"
    echo ""
    
    
    # Build the chained grep command dynamically
    input_file="words_ordered_by_path_sum.txt"
    command="grep '$base_regex' $input_file"
    
    if [[ ${#nonmembers[@]} -gt 0 ]]; then
        # Create pattern from array
        pattern="[${nonmembers[*]}]"
    
        # Remove spaces
        pattern="${pattern// /}"
    
        command+=" | grep -v '$pattern'"
    fi
    
    if [[ ${#members[@]} -gt 0 ]]; then
        # Create pattern from array
        pattern="[${members[*]}]"
    
        # Remove spaces
        pattern="${pattern// /}"
    
        command+=" | grep '$pattern'"
 
    fi
    
    command+=" | head | cut -f 1"
    
    echo "Command is:"
    echo $command

    # Execute the command
    echo "Next best guesses are:"
    eval $command
    echo ""

done


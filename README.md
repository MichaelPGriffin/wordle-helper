# README

This is a `bash` app for choosing words to use in Wordle.

It uses the Stanford Graphbase collection of 5 letter words available at Prof. Donald Knuth's webpage: https://www-cs-faculty.stanford.edu/~knuth/sgb-words.txt

The word list in this repo was sorted by placing all of the words in a prefix tree, calculating the total character frequency per word, and putting words with the greatest scores at the top of the list.

### How to use:
* Clone the repo
* Start a Wordle game
* Run `bash client.sh` or `./client.sh`
* Follow the prompts after each turn in Wordle


### Demo:

```
Welcome to 

                       _ _             _          _                 
                      | | |           | |        | |                
__      _____  _ __ __| | | ___       | |__   ___| |_ __   ___ _ __ 
\ \ /\ / / _ \| '__/ _` | |/ _ \______| '_ \ / _ \ | '_ \ / _ \ '__|
 \ V  V / (_) | | | (_| | |  __/______| | | |  __/ | |_) |  __/ |   
  \_/\_/ \___/|_|  \__,_|_|\___|      |_| |_|\___|_| .__/ \___|_|   
                                                   | |              
                                                   |_|      

Guess the word and enter the results here.
Use '*' for unknown letters

st***

You entered: "st***"

Enter characters known to be in the word.

Add a character or type 'next' to continue.

i

Add a character or type 'next' to continue.

n

Add a character or type 'next' to continue.

e

Add a character or type 'next' to continue.

next

Member characters:
i n e

Enter characters known to NOT be in the word

Add a character. Type 'next' to continue.

o

Add a character. Type 'next' to continue.

p

Add a character. Type 'next' to continue.

next

Non-member characters:
o p

Command is:
grep 'st\w\w\w' words_ordered_by_path_sum.txt | grep -v '[op]' | grep -P '^(?=.*i)(?=.*n)(?=.*e).*' | head | cut -f 1

Running command...

Next best guess(es):
stein

Guess the word and enter the results here.
Use '*' for unknown letters

```

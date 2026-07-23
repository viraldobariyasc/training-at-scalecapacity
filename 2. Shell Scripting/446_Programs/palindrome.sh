#!/bin/bash

# Function to check palindrome number
check_palindrome() {

    local number=$1
    local original=$number
    local reverse=0

    while [ $number -gt 0 ]
    do
        digit=$((number % 10))
        reverse=$((reverse * 10 + digit))
        number=$((number / 10))
    done

    if [ $original -eq $reverse ]
    then
        echo "$original is a Palindrome Number."
    else
        echo "$original is NOT a Palindrome Number."
    fi
}

# Main Program
read -p "Enter a number: " num

# Exception Handling
if ! [[ $num =~ ^[0-9]+$ ]]
then
    echo "Invalid input! Please enter a positive integer."
    exit 1
fi

check_palindrome "$num"

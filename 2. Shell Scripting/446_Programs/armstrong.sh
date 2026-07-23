#!/bin/bash

# Function to check Armstrong number
check_armstrong() {

    local number=$1
    local original=$number
    local sum=0
    local digits=${#number}

    while [ $number -gt 0 ]
    do
        digit=$((number % 10))
        sum=$((sum + digit ** digits))
        number=$((number / 10))
    done

    if [ $sum -eq $original ]
    then
        echo "$original is an Armstrong Number."
    else
        echo "$original is NOT an Armstrong Number."
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

check_armstrong "$num"

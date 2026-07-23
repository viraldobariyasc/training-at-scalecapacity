#!/bin/bash

# Function to check Prime Number
check_prime() {

    local number=$1

    if [ $number -lt 2 ]
    then
        echo "$number is NOT a Prime Number."
        return
    fi

    for ((i=2; i*i<=number; i++))
    do
        if [ $((number % i)) -eq 0 ]
        then
            echo "$number is NOT a Prime Number."
            return
        fi
    done

    echo "$number is a Prime Number."
}

# Main Program
read -p "Enter a number: " num

# Exception Handling
if ! [[ $num =~ ^[0-9]+$ ]]
then
    echo "Invalid input! Please enter a positive integer."
    exit 1
fi

check_prime "$num"

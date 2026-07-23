#!/bin/bash

# Function to call REST API
call_api() {

    url="https://typedomain.com/users/1"

    response=$(curl -s "$url")

    if [ $? -eq 0 ]
    then
        echo "API called successfully."
        echo
        echo "$response"
    else
        echo "Failed to call API."
    fi
}

# Main
call_api
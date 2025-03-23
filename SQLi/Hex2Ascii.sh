#!/bin/bash

convert_hex_to_ascii() {
    # Remove '0x' prefix if present and convert hex to ASCII
    echo -n "$1" | sed 's/^0x//' | xxd -r -p
    echo  # Ensure newline after output
}

convert_ascii_to_hex() {
    # Convert ASCII to hex and add '0x' prefix
    hex_value=$(echo -n "$1" | xxd -p | tr -d '\n')
    echo "0x$hex_value"
}

if [[ "$#" -eq 2 ]]; then
    case "$1" in
        -h|--hex)
            convert_hex_to_ascii "$2"
            ;;
        -a|--ascii)
            convert_ascii_to_hex "$2"
            ;;
        *)
            echo "Usage: $0 [-h HEX_VALUE] | [-a ASCII_VALUE]"
            exit 1
            ;;
    esac
else
    echo "Choose an option:"
    echo "1. Convert Hex to ASCII -a "
    echo "2. Convert ASCII to Hex -h "
    read -p "Enter your choice (1 or 2): " choice

    if [[ "$choice" == "1" ]]; then
        read -p "Enter Hex string (with or without 0x): " hex
        convert_hex_to_ascii "$hex"
    elif [[ "$choice" == "2" ]]; then
        read -p "Enter ASCII string: " ascii
        convert_ascii_to_hex "$ascii"
    else
        echo "Invalid choice!"
        exit 1
    fi
fi

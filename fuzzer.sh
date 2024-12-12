#!/bin/bash

# Help message for usage
usage() {
    echo "Usage: $0 -u <base-domain> -w <wordlist> [-i <include-status>]"
    echo "Options:"
    echo "  -u  Base domain to fuzz (e.g., linkvortex.htb)"
    echo "  -w  Wordlist file containing subdomains"
    echo "  -i  Include only specific HTTP status codes (comma-separated, e.g., 200,301)"
    exit 1
}

# Parse command-line arguments
INCLUDE_STATUS=""
while getopts "u:w:i:" opt; do
    case "$opt" in
        u) BASE_DOMAIN="$OPTARG" ;;
        w) WORDLIST="$OPTARG" ;;
        i) INCLUDE_STATUS="$OPTARG" ;;
        *) usage ;;
    esac
done

# Ensure mandatory arguments are provided
if [[ -z "$BASE_DOMAIN" || -z "$WORDLIST" ]]; then
    usage
fi

# Check if the wordlist file exists
if [[ ! -f "$WORDLIST" ]]; then
    echo "Error: Wordlist file '$WORDLIST' not found."
    exit 1
fi

# Convert include statuses to an array
IFS=',' read -r -a INCLUDE_ARRAY <<< "$INCLUDE_STATUS"

# Define color codes for output
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

# Get total number of subdomains
TOTAL=$(wc -l < "$WORDLIST")
CURRENT=0

echo "Starting fuzzing for $TOTAL subdomains..."

# Iterate through each subdomain in the wordlist
while read -r SUBDOMAIN; do
    ((CURRENT++))
    FULL_DOMAIN="${SUBDOMAIN}.${BASE_DOMAIN}"

    # Use curl to fetch the HTTP status code
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -H "Host: ${FULL_DOMAIN}" http://10.10.11.47)

    # Show progress every 10 entries
    if (( CURRENT % 10 == 0 )); then
        PERCENT=$((CURRENT * 100 / TOTAL))
        echo -ne "Progress: $CURRENT/$TOTAL ($PERCENT%)\r"
    fi

    # Check if the status code matches the include list
    if [[ -n "$INCLUDE_STATUS" ]]; then
        if [[ " ${INCLUDE_ARRAY[*]} " == *" $HTTP_STATUS "* ]]; then
            echo -e "${GREEN}Valid:${RESET} ${FULL_DOMAIN} -> $HTTP_STATUS"
        fi
    else
        # Show all results if -i is not provided
        if [[ "$HTTP_STATUS" == "200" ]]; then
            echo -e "${GREEN}Valid:${RESET} ${FULL_DOMAIN} -> $HTTP_STATUS"
        else
            echo -e "${RED}Invalid:${RESET} ${FULL_DOMAIN} -> $HTTP_STATUS"
        fi
    fi
done < "$WORDLIST"

# Final message
echo -e "\n\nScan complete! Processed $TOTAL subdomains."

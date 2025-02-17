#!/bin/bash

# Function to replace values
replace_value() {
    FROM=$1
    TO=$2
    
    if [ "${FROM}" = "${TO}" ]; then
        echo "Nothing to replace, the value is already set to ${TO}."
        return
    fi

    echo "Replacing all statically built instances of $FROM with $TO."

    find apps/web/.next/ apps/web/public -type f |
    while read file; do
        # Use perl instead of sed for better handling of special characters
        perl -pi -e "s|$FROM|$TO|g" "$file"
    done
}

# Replace URL
replace_value "$1" "$2"

# Replace App Name
DEFAULT_APP_NAME="Cal.com"
NEW_APP_NAME="${NEXT_PUBLIC_APP_NAME:-$DEFAULT_APP_NAME}"

if [ "$DEFAULT_APP_NAME" != "$NEW_APP_NAME" ]; then
    replace_value "$DEFAULT_APP_NAME" "$NEW_APP_NAME"
fi

# Replace Company Name
DEFAULT_COMPANY_NAME="Cal.com, Inc."
NEW_COMPANY_NAME="${NEXT_PUBLIC_COMPANY_NAME:-$DEFAULT_COMPANY_NAME}"

if [ "$DEFAULT_COMPANY_NAME" != "$NEW_COMPANY_NAME" ]; then
    replace_value "$DEFAULT_COMPANY_NAME" "$NEW_COMPANY_NAME"
fi
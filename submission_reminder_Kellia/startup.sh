#!/bin/bash

# Displaying startup message
echo "Starting Reminder app"

# Change to script's directory
path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$path"

#checking if reminder script exists and make it executable
if [ -f "./app/reminder.sh" ]; then
    chmod +x ./app/reminder.sh
else
    echo "Warning: ./app/reminder.sh not found"
fi

# Checking if functions script exists and make it executable
if [ -f "./modules/functions.sh" ]; then
     chmod +x ./modules/functions.sh
else
    echo "Warning: ./modules/functions.sh not found"
fi

# Checking if submissons file exists and exit if missing
if [ ! -f "./assets/submissions.txt" ]; then
     echo "Error: submissions.txt was not found in ./assets"
    exit 1
fi

# Checking for config file and loading it
if [ -f "./config/config.env" ]; then
    source ./config/config.env
else
     echo "Error: config.env not found"
    exit 1
fi

# Checking for functions script and loading it
if [ -f "./modules/functions.sh" ]; then
     source ./modules/functions.sh
else
     echo "Warning: ./modules/functions.sh not found"
fi

# Run reminder app if it exists
if [ -f "./app/reminder.sh" ]; then
     bash ./app/reminder.sh
else 
     echo "Warning: reminder.sh not found"
fi

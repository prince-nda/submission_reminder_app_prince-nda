#!/bin/bash

# Prompt user to enter their name
read -p "Enter your name: " user_name

# Prompt user for assignment details
echo ""
echo "Hello $user_name, Please Enter your new assignment name"
read -p "Assignment name: " newAssignment

# Checking if assignment name is not empty
if [ -z "$newAssignment" ]; then
   echo "Error: Assignment name  can not be empty"
   exit 1

fi
# Set paths for both confing and startup files
config_path="./submission_reminder_$user_name/config/config.env"
startup_path="./submission_reminder_$user_name/startup.sh"

# Updating assignment name for config file
if sed -i '2s/^ASSIGNMENT=.*/ASSIGNMENT="'"$newAssignment"'"/' "$config_path"; then
         echo "Assignment updated to: $newAssignment"
   else

   echo "Error: Failed to update config file"
   exit 1

fi

# Display startup message
echo "Running startup script"

# Checking if startup script exists and make it executable
if [ -f "$startup_path" ]; then
    chmod +x "$startup_path"
    bash "$startup_path"
    exit 0
  else
   echo "Error: startup.sh not found for $user_name"
   exit 1
fi

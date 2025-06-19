#!/bin/bash

#prompt user to enter their name
read -p "Enter your name: " yourName

# Checking if name is empty
if [ -z "$yourName" ]; then
  echo "Error: Name can not be empty"
 exit 1
fi

# creating directory for the user
main_dir="submission_reminder_${yourName}"
mkdir -p "$main_dir"
echo "created directory: $main_dir"

# creating subdirectories
mkdir -p "$main_dir/app"
mkdir -p "$main_dir/modules"
mkdir -p "$main_dir/assets"
mkdir -p "$main_dir/config"

cat << 'EOL' > "$main_dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOL

cat << 'EOL' > "$main_dir/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOL

cat << 'EOL' > "$main_dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Kellia, Shell Permissions, not submitted
Kessy, Shell Basics, submitted
Christian, Shell Permissions, not submitted
Calvin, Shell redirections, not submitted
Jovan, Shell Basics, submitted
Nilvan, Shell Basics, submitted
David, Shell Navigation, not submitted
Loura, Emacs, submitted
EOL

cat << 'EOL' > "$main_dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

cat << 'EOL' > "$main_dir/startup.sh"
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
EOL

# Set execute permissions on all shell files
for file in $(find "$main_dir" -name "*.sh"); do
         chmod +x "$file"
done

# Display completion message
echo "Environment setup completed successfully"

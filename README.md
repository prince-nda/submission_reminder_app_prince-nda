**Individual Summative Lab**

**Submission Reminder App**

**This submission reminder app** is a bash based tool that allows students to create a personalized environment to track and alert them about upcoming assignment deadlines.

**Here's what it does**

. prompts user to enter their name and assignment

. creates a folder structure with scripts and configuration files

. lists students who did not submit the current assignment

. can update assignemnts later using copilot script


**Project structure**

After running your create_environment.sh, your project will look like this

**.submisssion_reminder_yourname**
.
├── app
│   └── reminder.sh
├── assets
│   └── submissions.txt
├── config
│   └── config.env
├── modules
│   └── functions.sh
└── startup.sh


**How to run the application**

setup the  environment

this will prompt for your name and create full project structure

**NOTES,**

.Make sure you run create_environment.sh first before anything else.

.The config file supports updating the current assignment and remaining days. 

# Autorian

## Pre-reqs
CSV files must meet certain criteria for autorian to work
1. First line has to be a header containing the names of all the columns
2. Each row is separated by a newline

## Usage
autorian can be run with this command:

./autorian.sh CSV USERS OUTPUT PARAMS
CSV is the CSV file
USERS is a file listing users separated by newlines
OUTPUT is where you want the output to go
PARAMS are in this format: "COLUMN1='VALUE1'" "COLUMN2='VALUE2'" etc..

So an example command would be this:

./autorian.sh video_report_FullScreen_V_1.csv users.txt output.txt "claimed_by_this_owner='Yes'" "length >= 0"

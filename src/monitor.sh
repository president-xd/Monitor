#!/usr/bin/env bash

# Prompt user for input
read -p "Enter the date (e.g., '2024-08-25 14:00:00'): " user_date
echo "(FORMAT: 'YYYY-MM-DD HH:MM:SS')"
read -p "Enter the log file location (e.g., '/var/log/auth.log'): " log_file
echo "(FORMAT: '/path/to/logfile')"

# Convert user-provided date to timestamp
start_time="$(date -d "$user_date - 1 hour" +'%s')"
end_time="$(date -d "$user_date" +'%s')"

# Read the log file and filter entries based on the time range
sudo cat "$log_file" | while read -r line; do
    time_stamp=$(echo "$line" | cut -d ' ' -f 1-3)
    time_stamp=$(date -d "$time_stamp" +'%s')
    if [ "$time_stamp" -ge "$start_time" -a "$time_stamp" -le "$end_time" ]; then
        echo "$line"
    fi
done

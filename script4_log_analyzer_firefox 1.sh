#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: [Anmol Chauhan] | Roll No: [24bec10068]
# Course: Open Source Software
# Chosen Software: Firefox
# Description: Reads a log file line by line using a while-read
#              loop, counts how many lines contain a given
#              keyword, shows the last 5 matching lines, and
#              retries if the file is empty.
#              Also checks Firefox crash report directories.
#
# Usage  : ./script4_log_analyzer_firefox.sh <logfile> [keyword]
# Example: ./script4_log_analyzer_firefox.sh /var/log/syslog error
# Example: ./script4_log_analyzer_firefox.sh /var/log/syslog warning
# ============================================================

# ---------------------------------------------------------------
# Command-line arguments:
#   $1 = path to the log file the user wants to analyze (required)
#   $2 = keyword to search for (optional — defaults to "error")
#
# $0 = the script name itself
# $1, $2, $3 ... = arguments passed when running the script
# ---------------------------------------------------------------
LOGFILE=$1
KEYWORD=${2:-"error"}    # If no keyword given, default to "error"

# Counter variable — starts at 0, incremented for each match found
COUNT=0

# Maximum retry attempts if the file turns out to be empty
MAX_RETRIES=3

echo "================================================================"
echo "          OPEN SOURCE AUDIT — LOG FILE ANALYZER                "
echo "          Chosen Software: Mozilla Firefox                      "
echo "================================================================"
echo ""
echo "  Log File : ${LOGFILE:-[not provided]}"
echo "  Keyword  : $KEYWORD"
echo ""

# ---------------------------------------------------------------
# STEP 1: Validate that the user provided a log file as $1
# [ -z "$LOGFILE" ] returns true (exit 0) if the variable is
# empty or unset — meaning no argument was passed.
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  STEP 1: Validate Input"
echo "----------------------------------------------------------------"
echo ""

if [ -z "$LOGFILE" ]; then
    # No file argument provided — show usage instructions and exit
    echo "  ERROR: No log file specified."
    echo ""
    echo "  Usage   : $0 <logfile> [keyword]"
    echo "  Example : $0 /var/log/syslog error"
    echo "  Example : $0 /var/log/syslog warning"
    echo ""
    echo "  Common Linux log files you can use:"
    echo "    /var/log/syslog        — general system log (Ubuntu/Debian)"
    echo "    /var/log/messages      — general system log (Fedora/RHEL)"
    echo "    /var/log/auth.log      — login and authentication events"
    echo "    /var/log/kern.log      — kernel messages"
    echo "    /var/log/dpkg.log      — package install/remove history"
    echo ""
    echo "  TIP: Firefox does not write to system logs directly."
    echo "  Use keyword 'error' or 'warning' on /var/log/syslog"
    echo "  for the best demonstration of this script."
    exit 1
fi

# ---------------------------------------------------------------
# STEP 2: Check that the file actually exists on disk.
# [ ! -f "$LOGFILE" ] is true if the path does NOT exist
# as a regular file — could be wrong path or no read permission.
# ---------------------------------------------------------------
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File not found — '$LOGFILE'"
    echo ""
    echo "  Possible reasons:"
    echo "    1. The file path is incorrect"
    echo "    2. You do not have read permission — try: sudo $0 $LOGFILE $KEYWORD"
    echo "    3. The file does not exist on this system"
    echo ""
    exit 1
fi

echo "  Input validated successfully."
echo "  File     : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive search)"
echo ""

# ---------------------------------------------------------------
# STEP 3: Do-while style retry loop
#
# Bash does not have a native do-while loop, so we simulate it:
#   - Use a while loop with a counter variable
#   - Check if file is empty using [ ! -s ]
#   - If empty, increment counter and retry after 2 seconds
#   - If counter reaches MAX_RETRIES, exit with an error
#   - If file has content, break out of the loop immediately
#
# [ ! -s "$LOGFILE" ] returns true if the file is empty (size = 0)
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  STEP 2: Check File Is Not Empty (retry loop)"
echo "----------------------------------------------------------------"
echo ""

RETRY=0

while [ $RETRY -lt $MAX_RETRIES ]; do

    if [ ! -s "$LOGFILE" ]; then
        # File exists but has zero content
        RETRY=$((RETRY + 1))
        echo "  WARNING: '$LOGFILE' appears to be empty."
        echo "           Attempt $RETRY of $MAX_RETRIES..."

        if [ $RETRY -ge $MAX_RETRIES ]; then
            echo ""
            echo "  File is still empty after $MAX_RETRIES attempts."
            echo "  Cannot analyze an empty file. Exiting."
            exit 1
        fi

        echo "  Retrying in 2 seconds..."
        sleep 2

    else
        # File has content — break out of the retry loop
        echo "  File has content. Proceeding with analysis..."
        break
    fi

done
# --- end of retry while loop ---

echo ""

# ---------------------------------------------------------------
# STEP 4: Read the log file line by line using a while-read loop
#
# This is the core of the script. The while-read loop reads
# the file ONE LINE AT A TIME — memory-efficient for large files.
#
# Syntax:
#   while IFS= read -r LINE; do
#       ... process $LINE ...
#   done < "$LOGFILE"
#
#   IFS=   — sets Input Field Separator to empty, preserving
#             leading/trailing whitespace in each line
#   -r     — raw mode: backslash (\) is treated as a literal
#             character, not as an escape sequence
#   < "$LOGFILE" — redirects the file as input to the loop
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  STEP 3: Analyzing Log File (while-read loop)"
echo "----------------------------------------------------------------"
echo ""
echo "  Reading file line by line..."
echo ""

# Reset counter before the loop begins
COUNT=0

while IFS= read -r LINE; do

    # if-then inside the while loop:
    # Check if this line contains the keyword (case-insensitive).
    # 'echo "$LINE"' pipes the line to grep.
    # grep -iq : -i = ignore case,  -q = quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then

        # Keyword found in this line — increment the counter
        COUNT=$((COUNT + 1))

    fi

done < "$LOGFILE"
# --- end of while-read loop ---

# ---------------------------------------------------------------
# STEP 5: Display analysis results
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  STEP 4: Analysis Results"
echo "----------------------------------------------------------------"
echo ""

# Count total lines in the file using wc -l
# The < "$LOGFILE" redirect avoids printing the filename
TOTAL_LINES=$(wc -l < "$LOGFILE")

echo "  Log file         : $LOGFILE"
echo "  Total lines      : $TOTAL_LINES"
echo "  Keyword searched : '$KEYWORD'  (case-insensitive)"
echo "  Matching lines   : $COUNT"

# Calculate percentage only if file has lines (avoid divide by zero)
if [ "$TOTAL_LINES" -gt 0 ]; then
    # Integer arithmetic in bash uses $(( ))
    # We multiply by 100 first to keep precision before dividing
    PERCENT=$(( (COUNT * 100) / TOTAL_LINES ))
    echo "  Match rate       : ~${PERCENT}%"
fi

# Give a plain English summary based on count
echo ""
if [ "$COUNT" -eq 0 ]; then
    echo "  Result: No lines containing '$KEYWORD' were found."
    echo "          Try a different keyword: warning, failed, denied"
elif [ "$COUNT" -lt 10 ]; then
    echo "  Result: A small number of matches found. System looks healthy."
elif [ "$COUNT" -lt 50 ]; then
    echo "  Result: Moderate number of matches. Worth investigating."
else
    echo "  Result: High number of matches. Recommend reviewing the log."
fi

echo ""

# ---------------------------------------------------------------
# STEP 6: Show the last 5 matching lines
#
# We cannot use tail on the whole file (it would show last 5 lines
# regardless of keyword). Instead we:
#   1. Use grep -i to filter only matching lines
#   2. Pipe to tail -5 to get the last 5 of those matches
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  STEP 5: Last 5 Matching Lines"
echo "----------------------------------------------------------------"
echo ""

# grep -i : case-insensitive search
# tail -5 : show only the last 5 results
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

# [ -n "$MATCHES" ] is true if MATCHES string is NOT empty
if [ -n "$MATCHES" ]; then
    echo "$MATCHES"
else
    echo "  (No matching lines found for keyword '$KEYWORD')"
fi

echo ""

# ---------------------------------------------------------------
# STEP 7: Firefox-specific crash log check
#
# Firefox does not write to system logs like /var/log/syslog.
# Instead it keeps its own crash reports in the user's home dir.
# This section checks if those crash directories exist and
# reports how many crash files are present.
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  STEP 6: Firefox Crash Report Directory Check"
echo "----------------------------------------------------------------"
echo ""

# Main Firefox crash reports folder
CRASH_BASE="$HOME/.mozilla/firefox/Crash Reports"

if [ -d "$CRASH_BASE" ]; then
    echo "  Firefox Crash Reports directory found:"
    echo "  $CRASH_BASE"
    echo ""

    # Pending = crashes not yet submitted to Mozilla
    PENDING_DIR="$CRASH_BASE/pending"
    if [ -d "$PENDING_DIR" ]; then
        PENDING_COUNT=$(ls "$PENDING_DIR" 2>/dev/null | wc -l)
        echo "  Pending (unsent) crash reports : $PENDING_COUNT"
    else
        echo "  Pending crash reports folder   : not found"
    fi

    # Submitted = crashes already sent to Mozilla's crash server
    SUBMITTED_DIR="$CRASH_BASE/submitted"
    if [ -d "$SUBMITTED_DIR" ]; then
        SUBMITTED_COUNT=$(ls "$SUBMITTED_DIR" 2>/dev/null | wc -l)
        echo "  Submitted crash reports        : $SUBMITTED_COUNT"
    else
        echo "  Submitted crash reports folder : not found"
    fi

    echo ""
    echo "  Open-source advantage:"
    echo "  Firefox crash reports are sent to Mozilla's public crash"
    echo "  analysis platform: https://crash-stats.mozilla.org"
    echo "  Anyone can search and view crash data — full transparency."
    echo "  Proprietary browser vendors keep crash data private."

else
    echo "  Firefox crash directory not found at:"
    echo "  $CRASH_BASE"
    echo ""
    echo "  This is normal if Firefox has never crashed on this system"
    echo "  or has not been launched yet."
fi

echo ""
echo "================================================================"
echo "  Script 4 complete."
echo "================================================================"

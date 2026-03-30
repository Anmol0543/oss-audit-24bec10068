#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: [Anmol Chauhan] | Roll No: [24bec10068]
# Course: Open Source Software
# Chosen Software: Firefox
# Description: Asks the user three interactive questions and
#              generates a personalised open-source philosophy
#              statement inspired by Firefox's mission, then
#              saves it to a uniquely named .txt file.
#
# Shell concepts demonstrated:
#   read              — interactive user input from stdin
#   String concat     — building paragraphs from multiple variables
#   > and >>          — creating and appending to files
#   date command      — embedding timestamps in output
#   Alias concept     — shown via comment (common shell shorthand)
#   Input validation  — checking empty strings with [ -z ]
#   Variables         — storing and reusing values throughout
# ============================================================

# --- Alias concept (demonstrated via comment as required) ---
# In an interactive shell session, you could define:
#   alias now='date "+%d %B %Y at %H:%M"'
# Then use 'now' anywhere instead of the full date command.
# Aliases make long commands reusable — a form of abstraction
# that mirrors the open-source principle of sharing useful tools.

# --- Generate a unique output filename using the current username ---
# $(whoami) is command substitution — replaces itself with the username
OUTPUT="manifesto_$(whoami)_firefox.txt"

# Get today's date in a human-readable format
DATE=$(date '+%d %B %Y')

# Get current time as well for the timestamp
TIME=$(date '+%H:%M:%S')

echo "================================================================"
echo "    OPEN SOURCE AUDIT — FIREFOX MANIFESTO GENERATOR            "
echo "================================================================"
echo ""
echo "  Mozilla Firefox was built on a belief: that the web belongs"
echo "  to everyone, and no single company should control it."
echo ""
echo "  Answer three questions to generate your own open-source"
echo "  philosophy statement — inspired by Firefox's mission."
echo ""
echo "----------------------------------------------------------------"
echo ""

# ---------------------------------------------------------------
# read -p : displays a prompt and waits for the user to type input.
# The typed value is stored in the named variable.
# This is how bash scripts collect interactive input from users.
# ---------------------------------------------------------------

# Question 1: An open-source tool they use every day
read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

# Question 2: What freedom means to them in one word
read -p "  2. In one word, what does 'freedom' mean to you in software? " FREEDOM
echo ""

# Question 3: Something they would build and share with the world
read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# ---------------------------------------------------------------
# Input validation: check that the user answered all three questions.
# [ -z "$VAR" ] returns true if the variable is empty.
# We use || (OR) to check all three — if any is empty, we exit.
# ---------------------------------------------------------------
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: All three questions must be answered."
    echo "  Please run the script again and provide all answers."
    exit 1
fi

echo "----------------------------------------------------------------"
echo "  Generating your Firefox-inspired manifesto..."
echo ""
sleep 1   # Brief pause for effect

# ---------------------------------------------------------------
# Build the manifesto using string variables and concatenation.
# Each paragraph is stored in a variable, then written to a file.
# Backslash at end of line continues a long string across lines.
# ---------------------------------------------------------------

# Opening — the Firefox story as context
INTRO="In 2002, a group of open-source volunteers looked at the internet \
and saw something alarming: a single browser from a single company \
was quietly becoming the gateway to all of human knowledge. \
Internet Explorer held 95% of the market, and it was closed, \
stagnant, and broken. The web was being shaped by one corporation's \
priorities — not by the people who used it every day."

# Paragraph 1: Personal connection to open-source tools
PARA1="I use $TOOL every day. Like Firefox, it was not built to extract value \
from its users — it was built to give something to them. \
Every time I open it, I am using the work of contributors who chose \
to spend their time building something anyone could use, inspect, \
and improve. That choice — to give rather than to lock — is what \
separates open-source software from everything else."

# Paragraph 2: Philosophy of freedom
PARA2="To me, freedom in software means $FREEDOM. \
Firefox's Mozilla Public License 2.0 is a statement of that belief: \
the source code of the browser that hundreds of millions of people use \
to access the world is open for anyone to read, audit, and challenge. \
No hidden data collection engine. No locked API that favors the parent \
company's services. Just a browser built to serve its users — licensed \
to guarantee it stays that way."

# Paragraph 3: Personal commitment
PARA3="If I were to build something and share it freely, it would be $BUILD. \
I would write it in public, document it clearly, license it openly, \
and welcome every contributor who found it useful. Because Firefox \
taught me that open source is not charity — it is the most effective \
way to build software that actually serves people rather than \
extracting value from them."

# Paragraph 4: Closing reflection
PARA4="The web was designed to be open. HTTP is a published standard. \
HTML is a published standard. The idea that the software we use to \
access that web should be secret and proprietary is a contradiction \
at the heart of how the internet was imagined. Firefox exists to hold \
that line. I intend to hold it too — one open project at a time."

# ---------------------------------------------------------------
# Write the manifesto to the output file.
#   >  creates the file (or overwrites it if it exists)
#   >> appends to the existing file
# This is the standard way to write output to files in bash.
# ---------------------------------------------------------------

# Create the file and write the header (> overwrites)
echo "================================================================" > "$OUTPUT"
echo "          MY OPEN SOURCE MANIFESTO — FIREFOX EDITION           " >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Author   : $(whoami)" >> "$OUTPUT"
echo "  Date     : $DATE at $TIME" >> "$OUTPUT"
echo "  Course   : Open Source Software" >> "$OUTPUT"
echo "  Software : Mozilla Firefox (MPL 2.0)" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "  THE CONTEXT: WHY FIREFOX EXISTS" >> "$OUTPUT"
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$INTRO" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "  MY PHILOSOPHY" >> "$OUTPUT"
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Append each paragraph to the file using >>
echo "$PARA1" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA2" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA3" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA4" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Append a personal summary section
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "  MY ANSWERS" >> "$OUTPUT"
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Open-source tool I use daily : $TOOL" >> "$OUTPUT"
echo "  Freedom means to me          : $FREEDOM" >> "$OUTPUT"
echo "  I will build and share       : $BUILD" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "----------------------------------------------------------------" >> "$OUTPUT"
echo "  'The mission of Mozilla is to ensure the internet is a global" >> "$OUTPUT"
echo "   public resource, open and accessible to all.'" >> "$OUTPUT"
echo "                                      — Mozilla Foundation Mission" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"

# ---------------------------------------------------------------
# Confirm the file was saved and display its contents using cat
# cat reads a file and prints it to standard output (the terminal)
# ---------------------------------------------------------------
echo ""
echo "  Your manifesto has been saved to: $OUTPUT"
echo ""
echo "================================================================"
echo ""

# Display the completed manifesto in the terminal
cat "$OUTPUT"

echo ""
echo "================================================================"
echo "  Done! Upload $OUTPUT to your GitHub repo as part of your"
echo "  OSS Audit submission."
echo "================================================================"

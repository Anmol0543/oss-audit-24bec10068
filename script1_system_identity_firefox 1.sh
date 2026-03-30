#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: [ANMOL CHAUHAN] | Roll No: [24BEC10068]
# Course: Open Source Software
# Chosen Software: Firefox
# Description: Displays a welcome screen with key system info
#              including kernel version, user, uptime, date,
#              and the open-source license that covers the OS.
# ============================================================

# --- Ask for student details interactively ---
# This avoids any issues with editing variables inside the script.
# 'read -p' displays the prompt and waits for keyboard input.

echo "================================================================"
echo "          OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT           "
echo "          Chosen Software: Mozilla Firefox                      "
echo "================================================================"
echo ""

read -p "  Enter your Full Name   : " ANMOL_CHAUHAN
read -p "  Enter your Roll Number : " 24BEC10068

# Set the chosen software name directly as a string variable
SOFTWARE_CHOICE="Mozilla Firefox"

echo ""
echo "  Thank you, $STUDENT_NAME! Generating your system report..."
echo ""
sleep 1

# ---------------------------------------------------------------
# Gather System Information using command substitution $()
# Each variable stores the output of a command run at that moment
# ---------------------------------------------------------------

# Get the Linux kernel version
KERNEL=$(uname -r)

# Get the full OS/distribution name from the release file
DISTRO=$(grep PRETTY_NAME /etc/os-release | cut -d '=' -f2 | tr -d '"')

# Get the currently logged-in username
USER_NAME=$(whoami)

# Get the home directory of the current user
HOME_DIR=$HOME

# Get human-readable system uptime
UPTIME=$(uptime -p)

# Get current date and time in a readable format
CURRENT_DATE=$(date '+%A, %d %B %Y')
CURRENT_TIME=$(date '+%H:%M:%S')

# The Linux kernel is licensed under GPL v2
OS_LICENSE="GNU General Public License version 2 (GPL v2)"

# Firefox is licensed under Mozilla Public License 2.0
FIREFOX_LICENSE="Mozilla Public License 2.0 (MPL 2.0)"

# ---------------------------------------------------------------
# Display the full System Identity Report
# ---------------------------------------------------------------

echo "================================================================"
echo "          OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT           "
echo "================================================================"
echo ""
echo "  Student     : $ ANMOL_CHAUHAN"
echo "  Roll No     : $ 24BEC10068"
echo "  Software    : $SOFTWARE_CHOICE"
echo ""
echo "----------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "----------------------------------------------------------------"
echo ""
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged In As : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "----------------------------------------------------------------"
echo "  OPEN SOURCE LICENSES ON THIS SYSTEM"
echo "----------------------------------------------------------------"
echo ""
echo "  Operating System License : $OS_LICENSE"
echo ""
echo "  The GPL v2 ensures the Linux kernel remains free and open."
echo "  Any changes distributed publicly must also be open-sourced."
echo "  This principle — called 'copyleft' — protects user freedoms."
echo ""
echo "  Firefox License          : $FIREFOX_LICENSE"
echo ""
echo "  The MPL 2.0 is a weak copyleft license. It requires that"
echo "  any changes to MPL-licensed files be shared openly, but"
echo "  allows combining with proprietary code in larger products."
echo ""

# ---------------------------------------------------------------
# Check if Firefox is installed on this system using 'which'
# 'which' searches PATH for the binary and returns its location
# ---------------------------------------------------------------
FIREFOX_PATH=$(which firefox 2>/dev/null)

if [ -n "$FIREFOX_PATH" ]; then
    FIREFOX_VERSION=$(firefox --version 2>/dev/null)
    echo "  Firefox Status  : INSTALLED"
    echo "  Firefox Binary  : $FIREFOX_PATH"
    echo "  Firefox Version : $FIREFOX_VERSION"
else
    echo "  Firefox Status  : Not found in PATH"
    echo "  Install with    : sudo apt install firefox"
fi

echo ""
echo "================================================================"
echo "  Audit completed by $STUDENT_NAME ($ROLL_NUMBER)"
echo "  Date : $CURRENT_DATE"
echo "================================================================"

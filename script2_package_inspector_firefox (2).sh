#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: [ANMOL CHAUHAN] | Roll No: [24BEC10068]
# Course: Open Source Software
# Chosen Software: Firefox
# Description: Checks whether Firefox is installed on the system,
#              displays its version and license info, and prints
#              a philosophy note about it using a case statement.
# Usage: ./script2_package_inspector_firefox.sh
# ============================================================

# --- Set the package name to inspect ---
PACKAGE="firefox"

echo "================================================================"
echo "        OPEN SOURCE AUDIT — FOSS PACKAGE INSPECTOR             "
echo "        Chosen Software: Mozilla Firefox                        "
echo "================================================================"
echo ""
echo "  Inspecting package : $PACKAGE"
echo ""
echo "----------------------------------------------------------------"
echo "  STEP 1: Detect Package Manager"
echo "----------------------------------------------------------------"
echo ""

# ---------------------------------------------------------------
# Detect which package manager is available on this Linux system.
# Different distributions use different tools:
#   dpkg / apt  — Debian, Ubuntu, Linux Mint
#   rpm / dnf   — Fedora, RHEL, CentOS, Rocky Linux
# 'command -v' checks if a command exists in the system PATH.
# '&>/dev/null' discards both stdout and stderr — we only need
# the exit code (0 = found, non-zero = not found).
# ---------------------------------------------------------------
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
    echo "  Package manager detected : dpkg (Debian/Ubuntu based system)"
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
    echo "  Package manager detected : rpm (Fedora/RHEL based system)"
else
    # Neither package manager found — cannot continue
    echo "  ERROR: No supported package manager found."
    echo "  This script requires either dpkg (Ubuntu) or rpm (Fedora)."
    exit 1
fi

echo ""
echo "----------------------------------------------------------------"
echo "  STEP 2: Check If Firefox Is Installed (if-then-else)"
echo "----------------------------------------------------------------"
echo ""

# ---------------------------------------------------------------
# if-then-else: Check whether the package is installed.
# We run the query silently (&>/dev/null) and check the exit code
# stored in the special variable $? (0 = success = installed).
# This is the core decision branch of the script.
# ---------------------------------------------------------------
if [ "$PKG_MANAGER" = "dpkg" ]; then
    # dpkg -l lists installed packages — exit 0 if found
    dpkg -l "$PACKAGE" &>/dev/null
else
    # rpm -q queries installed RPM packages — exit 0 if found
    rpm -q "$PACKAGE" &>/dev/null
fi

# Store the exit code immediately after the check
INSTALLED=$?

if [ $INSTALLED -eq 0 ]; then
    # --- Firefox IS installed ---
    echo "  STATUS: $PACKAGE is INSTALLED on this system."
    echo ""
    echo "----------------------------------------------------------------"
    echo "  STEP 3: Show Package Details"
    echo "----------------------------------------------------------------"
    echo ""

    if [ "$PKG_MANAGER" = "dpkg" ]; then
        # dpkg-query fetches version of the installed package
        VERSION=$(dpkg-query -W -f='${Version}' "$PACKAGE" 2>/dev/null)
        echo "  Package  : $PACKAGE"
        echo "  Version  : $VERSION"

        # apt-cache show gives a one-line description of the package
        SUMMARY=$(apt-cache show "$PACKAGE" 2>/dev/null \
                  | grep -m1 "^Description-en:" \
                  | cut -d: -f2-)
        echo "  Summary  :$SUMMARY"

        # Check if the copyright file exists (contains license details)
        COPYRIGHT_FILE="/usr/share/doc/$PACKAGE/copyright"
        if [ -f "$COPYRIGHT_FILE" ]; then
            echo "  License  : See $COPYRIGHT_FILE"
            grep -i "^License" "$COPYRIGHT_FILE" | head -2
        else
            echo "  License  : Mozilla Public License 2.0 (MPL 2.0)"
        fi

    else
        # rpm -qi gives version, license, and summary in one command
        # grep -E filters only the lines we care about
        rpm -qi "$PACKAGE" | grep -E "^Version|^License|^Summary|^URL"
    fi

    echo ""

    # Show the full path to the Firefox binary using 'which'
    BINARY_PATH=$(which "$PACKAGE" 2>/dev/null)
    if [ -n "$BINARY_PATH" ]; then
        echo "  Binary   : $BINARY_PATH"
    fi

    # Get Firefox version string directly from the binary
    FIREFOX_VERSION=$(firefox --version 2>/dev/null)
    echo "  Version  : $FIREFOX_VERSION"

    # Check if the Firefox user profile directory exists
    PROFILE_DIR="$HOME/.mozilla/firefox"
    if [ -d "$PROFILE_DIR" ]; then
        echo "  Profile  : $PROFILE_DIR  [exists]"
    else
        echo "  Profile  : $PROFILE_DIR  [not yet created — launch Firefox first]"
    fi

else
    # --- Firefox is NOT installed ---
    echo "  STATUS: $PACKAGE is NOT installed on this system."
    echo ""
    echo "  To install Firefox, run one of the following:"
    echo "    Ubuntu/Debian  : sudo apt install firefox"
    echo "    Fedora         : sudo dnf install firefox"
    echo "    RHEL/CentOS    : sudo dnf install firefox"
    echo "    Arch Linux     : sudo pacman -S firefox"
fi

echo ""
echo "----------------------------------------------------------------"
echo "  STEP 4: Open Source Philosophy (case statement)"
echo "----------------------------------------------------------------"
echo ""

# ---------------------------------------------------------------
# case statement: prints a philosophy note based on package name.
# Syntax:
#   case $VARIABLE in
#     pattern) commands ;;
#     pattern) commands ;;
#     *)       default  ;;
#   esac
# Each ';;' marks the end of one case block.
# The '*' pattern is the default — matches anything not listed.
# ---------------------------------------------------------------
case $PACKAGE in

    firefox)
        echo "  Mozilla Firefox — the browser that keeps the web open."
        echo ""
        echo "  In the early 2000s, Microsoft Internet Explorer had over"
        echo "  90% of the browser market. It was proprietary, stagnant,"
        echo "  and being used to shape the web around Microsoft's products."
        echo ""
        echo "  Before Netscape closed, its engineers did something rare:"
        echo "  they released the source code to the public. That decision"
        echo "  became Mozilla, and eventually Firefox."
        echo ""
        echo "  Firefox is licensed under the Mozilla Public License 2.0."
        echo "  MPL 2.0 is a 'weak copyleft' license — changes to any"
        echo "  MPL-licensed FILE must be shared openly, but Firefox can"
        echo "  be combined with proprietary code in larger products."
        echo "  This makes Firefox's core auditable while staying practical."
        echo ""
        echo "  'The mission of Mozilla is to ensure the internet is a"
        echo "   global public resource, open and accessible to all.'"
        ;;

    chromium)
        echo "  Chromium: The open-source engine behind Google Chrome."
        echo "  BSD licensed — the most permissive of all major browsers."
        echo "  Anyone can take the code and build a proprietary browser."
        ;;

    httpd | apache2)
        echo "  Apache HTTP Server: powers roughly 30% of all websites."
        echo "  Apache 2.0 license — permissive and business-friendly."
        echo "  Proof that open source can hold the internet together."
        ;;

    mysql | mariadb)
        echo "  MySQL/MariaDB: GPL v2 with a dual commercial license."
        echo "  A masterclass in open-source business models — free for"
        echo "  open projects, paid for proprietary commercial use."
        ;;

    vlc)
        echo "  VLC: Born in a French university to stream campus video."
        echo "  LGPL/GPL licensed. It plays anything, anywhere, for free."
        echo "  A reminder that open-source tools often start from a simple"
        echo "  personal need — and end up used by hundreds of millions."
        ;;

    git)
        echo "  Git: Linus Torvalds built it when BitKeeper revoked its"
        echo "  free license. GPL v2 — the same license that protects"
        echo "  the Linux kernel. Never be locked into a proprietary tool."
        ;;

    python3 | python)
        echo "  Python: Governed by the PSF license, shaped entirely by"
        echo "  community. No single company owns it. Proof that open"
        echo "  governance can produce the world's most popular language."
        ;;

    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice"
        echo "  when Oracle's ownership raised concerns. MPL 2.0 licensed."
        echo "  The fork proved that open licenses protect communities —"
        echo "  when a steward fails, the code and community live on."
        ;;

    *)
        # Default: runs for any package not explicitly listed above
        echo "  $PACKAGE is part of the global open-source ecosystem."
        echo "  Built on transparency, community contribution, and the"
        echo "  belief that good software should be shared freely."
        ;;

esac

echo ""
echo "================================================================"
echo "  Script 2 complete."
echo "================================================================"

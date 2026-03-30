#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: [ANMOL CHAUHAN] | Roll No: [24BEC10068]
# Course: Open Source Software
# Chosen Software: Firefox
# Description: Uses a for loop to iterate through important
#              Linux system directories and reports their
#              permissions, ownership, and disk usage.
#              Also checks Firefox-specific directories to
#              show where Firefox lives on a Linux filesystem.
# Usage: ./script3_disk_permission_auditor_firefox.sh
# ============================================================

echo "================================================================"
echo "       OPEN SOURCE AUDIT — DISK AND PERMISSION AUDITOR         "
echo "       Chosen Software: Mozilla Firefox                         "
echo "================================================================"
echo ""

# ---------------------------------------------------------------
# PART 1: Standard System Directory Audit
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  PART 1: Standard Linux System Directory Audit"
echo "----------------------------------------------------------------"
echo ""
echo "  These directories are part of the Linux Filesystem Hierarchy"
echo "  Standard (FHS) — every Linux system organises files this way."
echo ""

# --- Define the list of directories to audit as an array ---
# Arrays in bash are declared with parentheses and space-separated values.
# Each element is a directory path we want to inspect.
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/var/cache")

# Print a formatted table header using printf
# %-25s means left-aligned string in a 25-character wide column
printf "  %-20s %-12s %-10s %-10s %-8s\n" \
       "Directory" "Permissions" "Owner" "Group" "Size"
echo "  ---------------------------------------------------------------"

# ---------------------------------------------------------------
# for loop: go through each directory in the DIRS array one by one.
#
# Syntax:
#   for VARIABLE in "${ARRAY[@]}"; do
#       ... commands using $VARIABLE ...
#   done
#
# "${DIRS[@]}" expands all elements of the array.
# Quoting it with "" handles directory names that have spaces.
# ---------------------------------------------------------------
for DIR in "${DIRS[@]}"; do

    # [ -d "$DIR" ] checks if the path exists AND is a directory
    if [ -d "$DIR" ]; then

        # ls -ld lists the directory itself (not its contents)
        # awk '{print $1}' extracts field 1 — the permission string
        # Example permission string: drwxr-xr-x
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')

        # awk '{print $3}' extracts field 3 — the owner's username
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')

        # awk '{print $4}' extracts field 4 — the group name
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh gives human-readable size (e.g. 4.5M, 1.2G)
        # cut -f1 removes the directory name column, keeping only the size
        # 2>/dev/null suppresses "permission denied" errors (e.g. inside /home)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print a formatted row for this directory
        printf "  %-20s %-12s %-10s %-10s %-8s\n" \
               "$DIR" "$PERMS" "$OWNER" "$GROUP" "$SIZE"

    else
        # Directory does not exist on this system — print a note
        printf "  %-20s %s\n" "$DIR" "[not found on this system]"
    fi

done
# --- end of for loop ---

echo "  ---------------------------------------------------------------"
echo ""
echo "  HOW TO READ THE PERMISSION STRING:"
echo "  Example: drwxr-xr-x"
echo "    d   = it is a directory (- would mean a regular file)"
echo "    rwx = owner can Read, Write, eXecute"
echo "    r-x = group members can Read and eXecute (not write)"
echo "    r-x = all other users can Read and eXecute (not write)"
echo ""

# ---------------------------------------------------------------
# PART 2: Firefox-Specific Directory Audit
# This section documents Firefox's "Linux Footprint" —
# where it places its files across the Linux filesystem.
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  PART 2: Firefox-Specific Directory and File Audit"
echo "----------------------------------------------------------------"
echo ""
echo "  Firefox follows the Linux FHS and places files in standard"
echo "  locations. Below are the key paths checked on this system."
echo ""

# --- Array of Firefox-specific paths to inspect ---
# This covers the binary, libraries, desktop entry,
# system config, user profile, and user cache.
FIREFOX_PATHS=(
    "/usr/bin/firefox"
    "/usr/lib/firefox"
    "/usr/lib64/firefox"
    "/usr/share/applications/firefox.desktop"
    "/usr/share/doc/firefox"
    "/etc/firefox"
    "$HOME/.mozilla/firefox"
    "$HOME/.cache/mozilla/firefox"
)

# ---------------------------------------------------------------
# Another for loop — this time over Firefox-specific paths.
# We check each path using [ -f ] for files and [ -d ] for dirs.
# ---------------------------------------------------------------
for FPATH in "${FIREFOX_PATHS[@]}"; do

    if [ -f "$FPATH" ]; then
        # --- It is a regular file ---

        # Get permissions and owner/group of the file
        FPERMS=$(ls -l "$FPATH" | awk '{print $1}')
        FOWNER=$(ls -l "$FPATH" | awk '{print $3}')
        FGROUP=$(ls -l "$FPATH" | awk '{print $4}')

        # Get human-readable file size
        FSIZE=$(du -sh "$FPATH" 2>/dev/null | cut -f1)

        echo "  [FILE] $FPATH"
        printf "         %-14s %-10s %-10s %-8s\n" \
               "$FPERMS" "$FOWNER" "$FGROUP" "$FSIZE"
        echo ""

    elif [ -d "$FPATH" ]; then
        # --- It is a directory ---

        # ls -ld inspects the directory itself, not its contents
        FPERMS=$(ls -ld "$FPATH" | awk '{print $1}')
        FOWNER=$(ls -ld "$FPATH" | awk '{print $3}')
        FGROUP=$(ls -ld "$FPATH" | awk '{print $4}')

        # Count items inside the directory
        ITEM_COUNT=$(ls "$FPATH" 2>/dev/null | wc -l)

        # Get total size of the directory and its contents
        FSIZE=$(du -sh "$FPATH" 2>/dev/null | cut -f1)

        echo "  [DIR]  $FPATH"
        printf "         %-14s %-10s %-10s %-8s  items: %s\n" \
               "$FPERMS" "$FOWNER" "$FGROUP" "$FSIZE" "$ITEM_COUNT"
        echo ""

    else
        # --- Path does not exist on this system ---
        echo "  [----] $FPATH"
        echo "         Not found on this system."
        echo ""
    fi

done
# --- end of Firefox paths for loop ---

# ---------------------------------------------------------------
# PART 3: Firefox Binary Details
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  PART 3: Firefox Binary Information"
echo "----------------------------------------------------------------"
echo ""

# Use 'which' to find the full path to the Firefox executable
FIREFOX_BIN=$(which firefox 2>/dev/null)

if [ -n "$FIREFOX_BIN" ]; then
    # Firefox binary found — print detailed info

    echo "  Binary path    : $FIREFOX_BIN"

    # Get Firefox version directly from the binary
    FF_VERSION=$(firefox --version 2>/dev/null)
    echo "  Version        : $FF_VERSION"

    # Get binary permissions and ownership
    BIN_PERMS=$(ls -l "$FIREFOX_BIN" | awk '{print $1}')
    BIN_OWNER=$(ls -l "$FIREFOX_BIN" | awk '{print $3}')
    BIN_GROUP=$(ls -l "$FIREFOX_BIN" | awk '{print $4}')
    echo "  Permissions    : $BIN_PERMS"
    echo "  Owner          : $BIN_OWNER"
    echo "  Group          : $BIN_GROUP"

    # Check if firefox binary is a symbolic link
    if [ -L "$FIREFOX_BIN" ]; then
        # readlink -f resolves the symlink to the actual file
        REAL_PATH=$(readlink -f "$FIREFOX_BIN")
        echo "  Symlink target : $REAL_PATH"
    fi

else
    echo "  Firefox binary not found in PATH."
    echo "  Install with: sudo apt install firefox"
fi

echo ""

# ---------------------------------------------------------------
# PART 4: Why Permissions Matter — Security Explanation
# ---------------------------------------------------------------
echo "----------------------------------------------------------------"
echo "  PART 4: Why Firefox's File Permissions Matter for Security"
echo "----------------------------------------------------------------"
echo ""
echo "  /usr/bin/firefox"
echo "  Owned by root. Users cannot modify the binary without sudo."
echo "  This prevents malicious code from replacing the browser."
echo ""
echo "  /usr/lib/firefox"
echo "  Core libraries owned by root. Only the package manager"
echo "  (apt/dnf) can update these — protects against tampering."
echo ""
echo "  ~/.mozilla/firefox   (user profile)"
echo "  Owned by the current user. Contains bookmarks, history,"
echo "  saved passwords, and extensions. Private to each user."
echo "  This separation (system files vs user files) is a core"
echo "  Linux security principle — called the principle of"
echo "  least privilege."
echo ""
echo "  ~/.cache/mozilla/firefox"
echo "  Temporary cached web data. Owned by the user."
echo "  Safe to delete — Firefox recreates it when launched."
echo ""
echo "  Open-source security advantage:"
echo "  Because Firefox is open source under MPL 2.0, security"
echo "  researchers worldwide can audit exactly what it reads and"
echo "  writes on your disk. Proprietary browsers offer no such"
echo "  guarantee — you must simply trust the vendor."
echo ""
echo "================================================================"
echo "  Script 3 complete."
echo "================================================================"

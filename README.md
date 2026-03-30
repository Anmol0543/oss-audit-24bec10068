# OSS Audit — Git
### Open Source Software | VIT | Capstone Project

---

## Student Details

| Field | Details |
|-------|---------|
| **Name** | ANMOL CHOUHAN |
| **Registration Number** | 24BEC10068 |
| **Course** | Open Source Software |
| **Chosen Software** | Git |
| **License of Chosen Software** | GNU General Public License v2 (GPL v2) |

---

## About This Project

This repository contains five shell scripts written as part of the Open Source Audit
capstone project. The scripts demonstrate practical Linux command-line skills and
are centered around Git — the open-source distributed version control system created
by Linus Torvalds in 2005.

---

## Scripts Overview

### Script 1 — System Identity Report
**File:** `script1_system_identity.sh`

Displays a welcome screen showing the Linux distribution name, kernel version,
currently logged-in user, home directory, system uptime, current date and time,
and the open-source license that covers the operating system.

**Concepts used:** Variables, `echo`, command substitution `$()`, output formatting.

---

### Script 2 — FOSS Package Inspector
**File:** `script2_package_inspector.sh`

Checks whether Git is installed on the system, retrieves its version and license
information, and uses a case statement to print a philosophy note about the
chosen package.

**Concepts used:** `if-then-else`, `case` statement, `rpm`/`dpkg`, pipe with `grep`.

---

### Script 3 — Disk and Permission Auditor
**File:** `script3_disk_auditor.sh`

Loops through a list of important Linux system directories and reports the
permissions, owner, group, and disk usage of each. Also checks Git-specific
paths like the binary location and config files.

**Concepts used:** `for` loop, `du`, `ls -ld`, `awk`, `cut`.

---

### Script 4 — Log File Analyzer
**File:** `script4_log_analyzer.sh`

Reads a log file line by line, counts how many lines contain a given keyword,
and prints the last 5 matching lines as a summary.

**Concepts used:** `while read` loop, `if-then`, counter variables, command-line
arguments (`$1`, `$2`).

---

### Script 5 — Open Source Manifesto Generator
**File:** `script5_manifesto.sh`

Asks the user three interactive questions, then composes a personalised open
source philosophy statement and saves it to a .txt file.

**Concepts used:** `read` for user input, string concatenation, writing to file
with `>` and `>>`, `date` command, alias concept demonstrated via comment.

---

## How to Run the Scripts on Linux

### Step 1 — Clone this repository
```bash
git clone https://github.com/abhyansh24bec10027-spec/oss-audit-24BEC10027.git
cd oss-audit-24BEC10027
```

### Step 2 — Make the scripts executable
```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto.sh
```

### Step 3 — Run each script

**Script 1:**
```bash
./script1_system_identity.sh
```

**Script 2:**
```bash
./script2_package_inspector.sh
```

**Script 3:**
```bash
./script3_disk_auditor.sh
```

**Script 4** (requires a log file path as input):
```bash
./script4_log_analyzer.sh /var/log/syslog error
```

**Script 5:**
```bash
./script5_manifesto.sh
```

---

## Dependencies

| Dependency | Purpose |
|------------|---------|
| `bash` | Shell interpreter — required to run all scripts |
| `git` | Required for Script 2 (package inspection) |
| `coreutils` | Provides `du`, `ls`, `date`, `whoami`, `cut` |
| `grep` | Used for keyword searching in Scripts 2 and 4 |
| `rpm` or `dpkg` | Used in Script 2 for package info (depends on distro) |

All of these come pre-installed on standard Linux distributions.

---

## Tested On

- Ubuntu 22.04 LTS
- Fedora 38
- Any Debian/Red Hat based Linux distribution

---

*Submitted as part of the OSS NGMC Capstone Project — VITyarthi*
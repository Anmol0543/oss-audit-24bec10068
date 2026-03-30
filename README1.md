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

This repository contains the practical component of "The Open Source Audit" capstone project. The project involves a deep-dive audit of Firefox, a non-profit web browser governed by the Mozilla Foundation. It includes a technical analysis of its Linux footprint and five custom shell scripts that demonstrate core Linux administration and automation concepts

---

## Scripts Overview

### Script 1 — System Identity Report
**File:** `script1_system_identity_firefox 1.sh`

Displays a welcome screen showing the Linux distribution name, kernel version,
currently logged-in user, home directory, system uptime, current date and time,
and the open-source license that covers the operating system.

**Concepts used:** Variables, `echo`, command substitution `$()`, output formatting.

---

### Script 2 — FOSS Package Inspector
**File:** `script2_package_inspector_firefox (2).sh`

To fulfill the requirements of Script 2 (FOSS Package Inspector) for your Firefox project, you need a script that identifies if the software is present, extracts its metadata, and uses a case statement to provide a philosophical context.

**Concepts used:** `if-then-else`, `case` statement, `rpm`/`dpkg`, pipe with `grep`.

---

### Script 3 — Disk and Permission Auditor
**File:** `script3_disk_permission_auditor_firefox 1.sh`



**Concepts used:** `for` loop, `du`, `ls -ld`, `awk`, `cut`.

---

### Script 4 — Log File Analyzer
**File:** `script4_log_analyzer_firefox 1.sh`

Reads a log file line by line, counts how many lines contain a given keyword,
and prints the last 5 matching lines as a summary.

**Concepts used:** `while read` loop, `if-then`, counter variables, command-line
arguments (`$1`, `$2`).

---

### Script 5 — Open Source Manifesto Generator
**File:** `script5_manifesto_generator_firefox 1.sh`

Asks the user three interactive questions, then composes a personalised open
source philosophy statement and saves it to a .txt file.

**Concepts used:** `read` for user input, string concatenation, writing to file
with `>` and `>>`, `date` command, alias concept demonstrated via comment.

---

## How to Run the Scripts on Linux

### Step 1 — Clone this repository
```bash
git clone https://github.com/Anmol0543/oss-audit-24bec10068
cd oss-audit-24BEC10068
```

### Step 2 — Make the scripts executable
```bash
chmod +x script1_system_identity_firefox 1.sh
chmod +x script2_package_inspector_firefox (2).sh
chmod +x script3_disk_permission_auditor_firefox 1.sh
chmod +x script4_log_analyzer_firefox 1.sh
chmod +x script5_manifesto_generator_firefox 1.sh
```

### Step 3 — Run each script

**Script 1:**
```bash
./script1_system_identity_firefox 1.sh
```

**Script 2:**
```bash
./sscript2_package_inspector_firefox (2).sh
```

**Script 3:**
```bash
./script3_disk_permission_auditor_firefox 1.sh
```

**Script 4** (requires a log file path as input):
```bash
./script4_log_analyzer_firefox 1.sh/var/log/syslog error
```

**Script 5:**
```bash
./script5_manifesto_generator_firefox 1.sh
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
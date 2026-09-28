# RHEL 9 Foundations Practical Lab — CH01 to CH06

## Overview

This lab documents the practical Linux administration work completed while studying Chapters 01–06 of the RHEL 9 course.

The goal was not only to run Linux commands, but to build, verify, troubleshoot, and understand a small server environment.

## Environment

- OS: RHEL 9
- Virtualization: VMware
- Hostname: Server.kero
- Administrative user: kero-user
- Shared development group: developers
- Project path: /opt/projects/webapp

## Project Structure

A practical application directory was created under:

```text
/opt/projects/webapp/
├── config/
├── data/
├── logs/
└── scripts/

The directories were configured for shared group access using the developers group and SGID behavior.

Filesystem and File Management

Practiced:

Absolute and relative paths
Directory navigation
Creating files and directories
Copying files with cp
Moving and renaming files with mv
Removing files with rm
Pattern matching and wildcards
Inspecting files using file
Reading files using cat, head, and tail
Permissions and Shared Directories

Worked with a shared project directory under /opt/projects.

Practical topics included:

User, group, and other permissions
Group write permissions
SGID directories
Group inheritance
Permission troubleshooting

A real permission error was encountered when attempting to create a directory without write permission.

Administrative access was then configured for kero-user through the wheel group and verified using sudo.

Links and Inodes

Created and inspected:

Regular file copies
Hard links
Symbolic links

Used:

ls -li

to compare inode numbers.

Verified that a hard link shared the same inode as the original file, while a copied file and symbolic link had different inode numbers.

Also practiced relative symbolic-link targets.

Text Processing

Used Linux text-processing tools against the application configuration file:

grep
Basic regular expressions
cut
tr
Pipes

Example:

grep 'PORT' config/app.conf | cut -d'=' -f2

Used cut and tr together to extract configuration keys and convert them to lowercase.

I/O Redirection

Practiced:

> — create or overwrite output
>> — append output
<< — here document
| — pipe command output into another command

Generated:

data/config-keys.txt

from the application configuration.

Several incorrect redirection commands were intentionally diagnosed and corrected during the lab.

Vim

Edited the application configuration using Vim.

Final configuration included:

ENVIRONMENT=production
LOG_LEVEL=warning

The changes were verified using grep and cat.

Shell Variables

Created a shell variable:

APP_ENV=production

Verified its value using:

echo $APP_ENV

Tested variable behavior inside a child Bash shell and confirmed that a normal shell variable was not inherited.

Then used:

export APP_ENV

and verified inheritance by a child shell.

A persistent variable was also configured in ~/.bashrc:

export WEBAPP_HOME=/opt/projects/webapp

The configuration was loaded with:

source ~/.bashrc

and verified from a new shell.

Linux Help and Inspection

Practiced:

date
file
head
tail
history
man
Searching inside manual pages
Users and Groups

Created a temporary administration scenario using:

User: qa1
Group: qa-team

Practiced:

Creating groups
Creating users
UID and GID inspection
Primary groups
Supplementary groups
Modifying group membership
Login testing
User and group deletion

The user was added to the supplementary group with:

sudo usermod -aG qa-team qa1

Verification was performed using:

id qa1
getent group qa-team
Password Management

Assigned a password to the temporary user and configured password aging.

Policy:

Minimum password age: 1 day
Maximum password age: 30 days
Warning period:       7 days

Configured using:

sudo chage -m 1 -M 30 -W 7 qa1

Verified using:

sudo chage -l qa1
Login and Access Testing

Tested a real login using:

su - qa1

Verified the session using:

whoami
id
pwd

The temporary account and group were removed after testing.

Troubleshooting Performed

The lab included real troubleshooting rather than only successful command execution.

Issues diagnosed included:

Permission denied when writing to a directory without sufficient permissions
kero-user initially not being in the sudoers configuration
Adding kero-user to the wheel group
A restricted login shell causing:
This account is currently not available.
Restoring dev1 to /bin/bash
Incorrect shell variable syntax caused by spaces around =
Confusion between filename input and piped input
Incorrect use of >, >>, and <<
Command typos and verification using Linux tools
Cleanup

Temporary resources created for the user-management scenario were removed:

sudo userdel -r qa1
sudo groupdel qa-team

This returned the server to a clean state after testing.

Skills Practiced
RHEL 9 administration
Bash CLI
Linux filesystem management
File and directory permissions
SGID and group inheritance
Links and inodes
Text processing
Pipes and redirection
Vim
Shell environment variables
Linux users and groups
sudo and privilege management
Password aging
Troubleshooting
Verification and cleanup
Next Step

Continue with Chapter 07 and extend this lab as new Linux administration topics are learned.

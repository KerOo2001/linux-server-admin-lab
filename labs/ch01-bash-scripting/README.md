# CH01 - Bash Scripting Fundamentals

## Environment
- OS: Red Hat Enterprise Linux 9.8
- Shell: Bash
- User: kero-user

## Topics Covered

### 1. Shell Scripts
- Bash script structure
- Shebang (`#!/bin/bash`)
- Executing scripts using `bash` and `./`
- Execute permissions using `chmod`

### 2. Script Execution
- Running scripts with `bash script.sh`
- Executing scripts directly with `./script.sh`
- Using `source` to execute commands in the current shell
- Understanding shell built-in commands

### 3. Providing Output
- Using `echo` and `printf`
- Variables and command substitution (`$(command)`)
- Output redirection (`>`)
- Append redirection (`>>`)

## Practical Scripts

| File | Description |
|---|---|
| system-info.sh | Displays basic system information |
| test-shell.sh | Demonstrates variables and shell execution |
| output-lab.sh | Generates a formatted server report |
| server-report.txt | Sample script output |

## Key Commands

```bash
chmod u+x script.sh
bash script.sh
./script.sh
source script.sh
echo "Hello" > report.txt
echo "World" >> report.txt
```
## Learning Status

- [x] Shell scripting basics
- [x] Script execution methods
- [x] Variables and command substitution
- [x] Output formatting
- [x] Output redirection
- [ ] Advanced Bash scripting exercises

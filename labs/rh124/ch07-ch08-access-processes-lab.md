# CH07–CH08 Practical Lab: File Access & Process Management

## Environment

- OS: Red Hat Enterprise Linux 9
- Lab type: Local VMware virtual machine
- Main admin user: `kero-user`
- Administrative access: `root`

---

# CH07 — Controlling Access to Files

## Objectives

This lab covers practical Linux file access control, including:

- Standard file permissions
- Numeric and symbolic permission modes
- File ownership and group ownership
- SUID
- SGID
- Sticky Bit
- Default permissions and `umask`

## 1. Shared Development Directory with SGID

A shared project directory was configured for the `developers` group:

```text
/opt/projects/dev-team
```

The directory permissions were configured as:

```text
drwxrws--- root developers
```

The group was given write permission:

```bash
chmod g+w /opt/projects/dev-team
```

The SGID bit on the directory ensures that newly created files and directories inherit the directory's group.

### Verification

A file was created by `dev1`:

```bash
touch /opt/projects/dev-team/app.conf
```

The resulting ownership and permissions were:

```text
-rw-rw-r-- dev1 developers app.conf
```

This confirmed that the new file inherited the `developers` group from the parent directory.

## 2. Default Permissions with `umask`

The active `umask` for `dev1` was checked:

```bash
umask
```

Result:

```text
0002
```

For a new regular file:

```text
Base permissions: 666
umask:            002
Result:           664
```

The resulting file permissions were:

```text
-rw-rw-r--
```

This confirmed how `umask` removes permissions from the default permission set.

## 3. Shared Directory with Sticky Bit

A shared directory was created:

```bash
mkdir /opt/shared
chmod 777 /opt/shared
chmod +t /opt/shared
```

The resulting directory permissions were:

```text
drwxrwxrwt
```

The `t` in the others execute position indicates that the Sticky Bit is enabled.

### Verification

A file was created by `dev1`:

```bash
touch /opt/shared/dev1.txt
```

Then `dev2` attempted to remove the file:

```bash
rm /opt/shared/dev1.txt
```

The operation failed with:

```text
Operation not permitted
```

This demonstrated that the Sticky Bit prevents ordinary users from deleting or renaming files owned by other users inside a shared writable directory.

## 4. SUID Verification

The permissions of the `passwd` executable were inspected:

```bash
ls -l /usr/bin/passwd
```

Result:

```text
-rwsr-xr-x root root /usr/bin/passwd
```

The `s` in the owner's execute position indicates that SUID is enabled.

When a normal user executes `passwd`, the program runs with the effective user ID of the file owner (`root`) for the privileged operations it is designed to perform.

This allows users to change their own passwords without granting them general root access.

## CH07 Key Takeaways

- `chmod` changes file and directory permissions.
- `chown` changes ownership.
- SGID on a directory provides group inheritance for newly created content.
- Sticky Bit protects users' files inside shared writable directories.
- SUID allows an executable to run with the effective user ID of its owner.
- `umask` controls which permissions are removed from the default permissions of newly created files and directories.
---

# CH08 — Monitoring and Managing Linux Processes

## Objectives

This lab covers practical Linux process management, including:

- Running processes in the background
- Managing shell jobs
- Moving jobs between foreground and background
- Suspending and resuming jobs
- Inspecting processes with `ps`
- Filtering process output with `grep`
- Terminating processes with signals
- Monitoring system activity with `top`
- Managing process priority with `nice` and `renice`

## 1. Running a Background Process

A test process was started in the background:

```bash
sleep 600 &
```

The shell returned a Job ID and PID:

```text
[1] 4036
```

The job was verified using:

```bash
jobs
```

This demonstrated the difference between:

```text
Job ID → Used by the shell for job control
PID    → Used by the operating system to identify a process
```

## 2. Foreground, Suspend, and Background Job Control

The background job was moved to the foreground:

```bash
fg %1
```

The process was suspended using:

```text
Ctrl+Z
```

The job then appeared as:

```text
Stopped
```

It was resumed in the background using:

```bash
bg %1
```

This demonstrated basic shell job control using `fg`, `bg`, `jobs`, and `Ctrl+Z`.

## 3. Inspecting Processes with `ps`

Processes associated with the current terminal were inspected using:

```bash
ps
```

A running `sleep` process appeared with its PID.

A broader process listing can be displayed using:

```bash
ps -ef
```

The output was filtered for `sleep` processes using:

```bash
ps -ef | grep sleep
```

This demonstrated how a pipe can send the output of one command to another command for filtering.

## 4. Terminating Processes with Signals

A test process was terminated using:

```bash
kill 4235
```

Because no signal was explicitly specified, `kill` sent the default signal:

```text
SIGTERM (15)
```

The shell reported:

```text
Terminated
```

Another test process was forcefully terminated using:

```bash
kill -9 4283
```

This sent:

```text
SIGKILL (9)
```

The shell reported:

```text
Killed
```

The lab demonstrated that `SIGTERM` should normally be attempted before using `SIGKILL`.

## 5. Monitoring Processes with `top`

System activity was inspected using:

```bash
top
```

The output included:

- Load average
- Number of running and sleeping tasks
- CPU utilization
- Memory utilization
- Swap utilization
- Individual process information

An important CPU field observed was:

```text
id = CPU idle percentage
```

For example:

```text
80% idle ≈ 20% CPU busy
```

A specific process can be monitored using:

```bash
top -p PID
```

## 6. Starting a Process with `nice`

A new process was started with a Nice value of `10`:

```bash
nice -n 10 sleep 600 &
```

The process received:

```text
PID = 4375
```

It was inspected using:

```bash
top -p 4375
```

The output showed:

```text
PR = 30
NI = 10
```

This confirmed that the process started with the requested Nice value.

## 7. Changing Priority with `renice`

The priority of the running process was changed:

```bash
renice -n 15 -p 4375
```

The command reported:

```text
old priority 10, new priority 15
```

Verification with `top` showed:

```text
PR = 35
NI = 15
```

This confirmed that the Nice value changed successfully.

The priority rule demonstrated in the lab was:

```text
Lower NI  → Higher CPU scheduling priority
Higher NI → Lower CPU scheduling priority
```

## 8. Cleaning Up Lab Jobs

Remaining shell jobs were inspected:

```bash
jobs
```

Three test jobs remained:

```text
[1] Stopped
[2] Running
[3] Running
```

They were terminated together using their Job IDs:

```bash
kill %1 %2 %3
```

A final check with:

```bash
jobs
```

returned no output, confirming that no lab jobs remained.

## CH08 Key Takeaways

- `&` starts a command in the background.
- `jobs` displays jobs managed by the current shell.
- `fg` moves a job to the foreground.
- `Ctrl+Z` suspends the foreground job.
- `bg` resumes a suspended job in the background.
- `ps` displays process information.
- `grep` can filter process listings.
- `kill` sends signals to processes or shell jobs.
- `SIGTERM` requests graceful termination.
- `SIGKILL` forcefully terminates a process.
- `top` provides live process and system monitoring.
- `nice` sets the Nice value when starting a process.
- `renice` changes the Nice value of an existing process.
- Lower Nice values correspond to higher CPU scheduling priority.

---

# Lab Completion

CH07 and CH08 were completed through hands-on practice on a RHEL 9 virtual machine.

The exercises covered both Linux file access control and process management using real users, permissions, directories, jobs, processes, signals, and CPU priority controls.

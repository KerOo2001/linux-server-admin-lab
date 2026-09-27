# User and Group Management

## Objective

Configure Linux users and groups on a RHEL server and provide administrative access through group-based sudo permissions.

## Environment

* OS: Red Hat Enterprise Linux
* Hostname: Server
* Primary user: kero-user

## Groups

Created the following administrative group:

* `linuxadmins`

The group was created using `groupadd`.

## Users

Created the following user:

* `admin2`

The user was created using `useradd`.

## Group Membership

Added `admin2` to the `linuxadmins` group as a secondary group.

The membership was verified using:

```bash
id admin2
```

The result showed:

```text
uid=1001(admin2) gid=1002(admin2) groups=1002(admin2),1001(linuxadmins)
```

## Sudo Configuration

Configured the `linuxadmins` group to have sudo access using `visudo`.

The following rule was added:

```text
%linuxadmins ALL=(ALL) ALL
```

This allows members of the `linuxadmins` group to execute commands using `sudo`.

## Password Configuration

A password was configured for `admin2` using:

```bash
passwd admin2
```

## Verification

Logged in as `admin2` and verified sudo access using:

```bash
sudo id
```

The command returned:

```text
uid=0(root) gid=0(root) groups=0(root)
```

This confirmed that `admin2` could successfully execute commands with root privileges through sudo.

## What I Learned

* How to create Linux groups using `groupadd`.
* How to create users using `useradd`.
* The difference between primary and secondary groups.
* How to add a user to a secondary group using `usermod -aG`.
* How to configure group-based sudo access using `visudo`.
* How to set a user's password using `passwd`.
* How to verify user, group, and sudo configuration.
* The importance of verifying configuration changes instead of assuming that a command succeeded.

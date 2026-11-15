# CH13 - Archiving and Transferring Files

## Overview

This lab demonstrates practical file archiving, compression, restoration, and secure file transfer tasks on RHEL 9.

The lab covers:

- Creating archives with `tar`
- Creating gzip-compressed archives
- Listing archive contents without extraction
- Extracting and restoring archived files
- Extracting files to a specific destination
- Transferring files securely with `scp`
- Uploading and downloading files with `sftp`
- Understanding local and remote file locations during secure transfers

---

## Lab Environment

- Operating System: Red Hat Enterprise Linux 9
- Hostname: `Server.kero`
- User: `kero-user`
- Repository: `linux-server-admin-lab`

---

# Part 1 - Prepare the Lab Environment

Created directories for source files, backups, and restored files:

```bash
mkdir -p labs/ch13-lab/{source,backup,restore}
```

Created sample files:

```bash
echo "RHEL 9 CH13 Lab" > labs/ch13-lab/source/readme.txt
echo "Server configuration backup" > labs/ch13-lab/source/server.conf
echo "Application log sample" > labs/ch13-lab/source/app.log
```

Verified the directory structure:

```bash
tree labs/ch13-lab
```

Result:

```text
labs/ch13-lab
├── backup
├── restore
└── source
    ├── app.log
    ├── readme.txt
    └── server.conf
```

---

# Part 2 - Create a Tar Archive

The `tar` command can combine multiple files and directories into a single archive.

Basic syntax:

```bash
tar -cf archive.tar directory/
```

Important options:

```text
-c    Create an archive
-f    Specify the archive file
-v    Display files being processed
```

Example:

```bash
tar -cf source-backup.tar labs/ch13-lab/source/
```

A `.tar` file is an archive and is not necessarily compressed.

---

# Part 3 - Create a Compressed Tar Archive

Created a gzip-compressed archive of the lab source directory:

```bash
tar -czf labs/ch13-lab/backup/source-backup.tar.gz labs/ch13-lab/source/
```

Options used:

```text
-c    Create archive
-z    Compress using gzip
-f    Specify archive filename
```

The resulting archive was:

```text
labs/ch13-lab/backup/source-backup.tar.gz
```

Using `tar` with gzip allows archiving and compression to be performed in a single command.

---

# Part 4 - List Archive Contents

Before restoring an archive, its contents can be inspected without extracting the files.

Command used:

```bash
tar -tf labs/ch13-lab/backup/source-backup.tar.gz
```

Options:

```text
-t    List archive contents
-f    Specify archive file
```

Output:

```text
labs/ch13-lab/source/
labs/ch13-lab/source/readme.txt
labs/ch13-lab/source/server.conf
labs/ch13-lab/source/app.log
```

This verifies that the required files exist inside the backup.

---

# Part 5 - Extract and Restore an Archive

The archive was restored into a separate directory:

```bash
tar -xf labs/ch13-lab/backup/source-backup.tar.gz -C labs/ch13-lab/restore/
```

Options:

```text
-x    Extract archive
-f    Specify archive file
-C    Extract into a specific directory
```

Verified the restored files:

```bash
find labs/ch13-lab/restore -type f
```

Result:

```text
labs/ch13-lab/restore/labs/ch13-lab/source/readme.txt
labs/ch13-lab/restore/labs/ch13-lab/source/server.conf
labs/ch13-lab/restore/labs/ch13-lab/source/app.log
```

The backup was successfully extracted and the source files were restored.

---

# Part 6 - Secure File Transfer with SCP

`scp` is used to securely copy files between Linux systems over SSH.

General syntax:

```bash
scp SOURCE DESTINATION
```

## Copy a Local File to a Remote Server

Example:

```bash
scp backup.tar.gz admin2@192.168.88.150:/home/admin2/
```

This transfers:

```text
Local System
backup.tar.gz
        |
        | SCP over SSH
        v
Remote Server
/home/admin2/
```

## Copy a File from a Remote Server

Example:

```bash
scp admin2@192.168.88.150:/home/admin2/report.txt .
```

The `.` represents the current local directory.

The transfer direction is determined by the source and destination positions.

```text
Upload:

scp local-file user@server:/remote/path/

Download:

scp user@server:/remote/path/file .
```

---

# Part 7 - Secure File Transfer with SFTP

SFTP provides an interactive secure file transfer session over SSH.

Connect to a remote server:

```bash
sftp admin2@192.168.88.150
```

After authentication, an interactive prompt is provided:

```text
sftp>
```

Useful commands include:

```text
pwd      Show remote working directory
lpwd     Show local working directory

ls       List remote files
lls      List local files

put      Upload a file
get      Download a file

exit     Close the SFTP session
```

## Upload a File

A local file can be uploaded to the remote server using:

```text
sftp> put backup.tar.gz
```

Transfer direction:

```text
Local → Remote
```

## Download a File

A remote file can be downloaded using:

```text
sftp> get report.txt
```

Transfer direction:

```text
Remote → Local
```

## Check Local and Remote Locations

Remote working directory:

```text
sftp> pwd
```

Local working directory:

```text
sftp> lpwd
```

Remote files:

```text
sftp> ls
```

Local files:

```text
sftp> lls
```

Exit the session:

```text
sftp> exit
```

---

# Part 8 - SSH, SCP, and SFTP Comparison

| Tool | Purpose |
|---|---|
| `ssh` | Open a secure remote shell |
| `scp` | Directly copy files between systems |
| `sftp` | Interactive secure file transfer session |

All three technologies use SSH for secure communication.

---

# Key Tar Commands

Create an archive:

```bash
tar -cf backup.tar directory/
```

Create a gzip-compressed archive:

```bash
tar -czf backup.tar.gz directory/
```

List archive contents:

```bash
tar -tf backup.tar.gz
```

Extract an archive:

```bash
tar -xf backup.tar.gz
```

Extract into a specific directory:

```bash
tar -xf backup.tar.gz -C /destination/
```

Useful `tar` options:

```text
c = Create
t = List contents
x = Extract
v = Verbose
f = Archive file
z = gzip compression
```

---

# Key SCP Commands

Upload a file:

```bash
scp file.txt user@server:/remote/path/
```

Download a file:

```bash
scp user@server:/remote/path/file.txt .
```

Copy a directory recursively:

```bash
scp -r directory/ user@server:/remote/path/
```

---

# Key SFTP Commands

Connect:

```bash
sftp user@server
```

Inside the SFTP session:

```text
ls
lls
pwd
lpwd
put filename
get filename
exit
```

---

# Key Takeaways

During this lab:

- Created file archives using `tar`.
- Created compressed archives using gzip.
- Inspected archive contents before extraction.
- Restored files from a compressed archive.
- Used `-C` to control the extraction destination.
- Practiced the syntax for securely transferring files with `scp`.
- Practiced interactive secure file transfers with `sftp`.
- Used `put` to upload files and `get` to download files.
- Distinguished between `ssh`, `scp`, and `sftp`.
- Verified backup contents and restored files before considering the backup successful.

This lab demonstrates the core RHEL 9 Chapter 13 skills for archiving, compressing, restoring, and securely transferring files between Linux systems.

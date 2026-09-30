# Linux Server Administration Lab

Hands-on RHEL 9 system administration lab documenting my practical Linux learning journey.

## Environment

- Red Hat Enterprise Linux 9
- VMware
- Bash
- Git
- Windows / MobaXterm for remote SSH administration

## Current Progress

**Course:** CH01–CH10 completed
**Practical Labs:** CH01–CH10 practiced
**Next:** CH11

## Practical Work

Topics practiced so far include:

- Linux CLI and filesystem navigation
- File and directory management
- Permissions and shared directories
- SGID and group inheritance
- Hard links, symbolic links, and inodes
- grep, regex, cut, tr, and pipes
- I/O redirection
- Vim
- Shell variables and environment configuration
- Users and groups
- sudo and privilege management
- Password aging and account access
- File permissions and special permissions
- Process monitoring and management
- Services and daemons with systemd
- Remote administration with OpenSSH
- SSH key-based authentication
- SSH server configuration and hardening
- SSH troubleshooting and configuration validation
- Linux troubleshooting

## Lab Documentation

- [CH01–CH06 Foundations Practical Lab](labs/ch01-ch06-foundations-lab.md)
- [CH07–CH08 Access and Process Management Lab](labs/ch07-ch08-access-processes-lab.md)
- [CH09 Services and Daemons Lab](labs/ch09-services-daemons-lab.md)
- [CH10 Configuring and Securing SSH Lab](labs/ch10-ssh-lab.md)
- [Local Users and Groups](users-groups.md)

## CH10 Highlights

CH10 was practiced using MobaXterm as an SSH client and a RHEL 9 virtual machine as the SSH server.

The lab included:

- Remote SSH access
- ED25519 SSH key generation
- Public-key deployment with `ssh-copy-id`
- `authorized_keys` and `known_hosts`
- `PermitRootLogin`
- `PasswordAuthentication`
- Configuration validation with `sshd -t`
- Effective configuration inspection with `sshd -T`
- SSH service reload with `systemctl`
- Authentication testing from a real remote client
- Troubleshooting an Anaconda-generated configuration override under `/etc/ssh/sshd_config.d/`
- Restoring the original lab environment after testing

## Learning Workflow

Learn → Build → Verify → Troubleshoot → Document → Commit

## Next Step

Continue with RHEL 9 Chapter 11 and extend the lab with the next system administration topic.**Course:** CH01–CH10 completed

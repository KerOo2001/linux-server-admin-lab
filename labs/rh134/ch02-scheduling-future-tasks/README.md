# CH02 - Scheduling Future Tasks

## Environment

- Red Hat Enterprise Linux 9.8
- Bash
- Cron and Anacron
- systemd
- systemd-tmpfiles

## Objectives

Automate recurring system administration tasks, validate scheduled jobs, troubleshoot execution issues, and manage temporary files.

## Practical Projects

| Project | Technology | Status |
|---|---|---|
| One-time task scheduling | at / atd | Completed |
| Automated service monitoring | User Cron | Completed |
| Automated disk monitoring | System Cron | Completed |
| Daily hosts backup | Anacron | Completed |
| Automated memory monitoring | systemd Timer | Completed |
| Application temporary file management | systemd-tmpfiles | Completed |

## Project Files

- [Server monitoring script](scripts/server-monitor.sh)
- [User Crontab configuration](user-crontab.conf)
- [System Cron configuration](system-cron.conf)
- [Anacron configuration](anacron/anacrontab)
- [Memory monitoring service](systemd/memory-monitor.service)
- [Memory monitoring timer](systemd/memory-monitor.timer)
- [Temporary directory configuration](tmpfiles/company-app.conf)
- [Temporary file cleanup test](tmpfiles/cleanup-test.conf)

## Troubleshooting Experience

- Identified and resolved an orphaned Cron file.
- Diagnosed internal script redirection that prevented report accumulation.
- Used absolute paths to ensure reliable scheduled execution.
- Verified Cron execution through /var/log/cron.
- Simulated missed Anacron jobs using an isolated spool directory.
- Validated systemd units before installation.
- Verified automatic temporary file cleanup.

## Key Commands

```bash
atq
atrm
crontab -e
crontab -l
realpath
watch
anacron -T
systemctl list-timers --all
systemctl daemon-reload
systemd-analyze calendar
systemd-analyze verify
systemd-tmpfiles --create
systemd-tmpfiles --clean
```

## Validation Results

- User Cron execution verified at five-minute intervals.
- System Cron execution verified with root privileges.
- Anacron missed-job recovery successfully simulated.
- systemd Timer execution verified through service logs and generated reports.
- Temporary file permissions, ownership, creation, and cleanup verified.

## Notes

Configuration files contain lab-specific paths and usernames and should be reviewed before deployment on another system.

Generated logs, backups, and timestamp files are excluded from version control.

The isolated Anacron configuration was tested manually and was not integrated into the system startup process.

## Learning Status

Practical labs completed. Independent assessment pending.

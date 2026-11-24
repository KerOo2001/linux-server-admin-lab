# Chapter 03 - Tuning System Performance

## Lab Environment

- OS: Red Hat Enterprise Linux 9.8
- Hypervisor: VMware Workstation
- Hostname: Server.kero
- Course: RH134 - Red Hat System Administration II

## 1. Managing TuneD Service

```bash
sudo systemctl enable --now tuned
systemctl status tuned
```

## 2. Managing Tuning Profiles

```bash
tuned-adm list
tuned-adm active
tuned-adm recommend
sudo tuned-adm profile virtual-guest
sudo tuned-adm verify
```

## 3. Creating a Custom Profile

Custom profile location:

/etc/tuned/kero-performance/tuned.conf

```ini
[main]
summary=Custom performance profile for my server
include=virtual-guest

[sysctl]
vm.swappiness=10
```

Activate and verify:

```bash
sudo tuned-adm profile kero-performance
tuned-adm active
sysctl vm.swappiness
sudo tuned-adm verify
```

## 4. Troubleshooting

The custom profile successfully applied vm.swappiness=10.

However, full profile verification failed because CPU boost
controls were unavailable inside the virtual machine.

Diagnostic commands:

```bash
sudo systemctl restart tuned
sudo tail -n 50 /var/log/tuned/tuned.log
sudo grep -Ei 'error|warning|fail|verify' /var/log/tuned/tuned.log
```

Result:

- Swappiness verification: PASS
- CPU boost verification: FAIL
- Cause: CPU boost control unavailable in the guest environment.

Restore the recommended profile:

```bash
sudo tuned-adm profile "$(tuned-adm recommend)"
```

## 5. Cockpit

Explored Cockpit for managing and monitoring virtual machines.

## 6. Process Scheduling and Priority

Start background processes with different nice values:

```bash
nice -n 5 sleep 600 &
nice -n 10 sleep 600 &
nice -n 15 sleep 600 &
```

Monitor processes:

```bash
jobs -l
echo $!
ps -C sleep -o pid,comm,ni
ps -eo pid,user,comm,ni --sort=ni
top
```

Change process priority and terminate:

```bash
sudo renice -n -5 -p PID
kill PID
```

Nice values range from -20 to 19.

- Lower nice value: Higher scheduling priority.
- Higher nice value: Lower scheduling priority.

## Skills Acquired

- System performance tuning
- TuneD service administration
- Custom tuning profiles
- Kernel parameter configuration
- Log analysis and troubleshooting
- Process scheduling
- Process priority management

## Status

Completed - Theory and Hands-on Practice.

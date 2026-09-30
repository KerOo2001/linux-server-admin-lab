# CH09 - Controlling Services and Daemons

## Lab Environment

- Operating System: Red Hat Enterprise Linux 9
- Service Manager: `systemd`
- Service Management Tool: `systemctl`
- Primary Test Service: Apache HTTP Server (`httpd`)
- Additional Service Reviewed: OpenSSH Server (`sshd`)

---

## 1. Understanding Services and Daemons

Linux services are programs that can run in the background and provide system or network functionality.

Examples reviewed during this lab:

```text
httpd → Apache HTTP Server
sshd  → OpenSSH Server
```

On RHEL 9, `systemd` manages system services and units.

The `systemctl` command is used to interact with `systemd` and manage services.

## 2. Checking Apache Service Status

The Apache HTTP Server service was inspected using:

```bash
systemctl status httpd
```

Important service states observed during the lab:

```text
active (running)
inactive (dead)
```

The difference:

```text
active (running) → The service is currently running.
inactive (dead)  → The service is currently stopped.
```

An inactive service does **not** mean that the entire Linux server is down. It only describes the state of the specific service being inspected.

## 3. Starting and Stopping Services

Apache was started using:

```bash
systemctl start httpd
```

The result was verified using:

```bash
systemctl status httpd
```

Apache was also stopped during the lab:

```bash
systemctl stop httpd
```

This demonstrated that `start` and `stop` control the **current runtime state** of a service.

## 4. Enabling Services at Boot

The difference between starting and enabling a service was tested.

```bash
systemctl start httpd
```

starts Apache now, while:

```bash
systemctl enable httpd
```

configures Apache to start automatically during system boot.

Both actions can be performed together:

```bash
systemctl enable --now httpd
```

During the lab, enabling Apache created a symbolic link:

```text
/etc/systemd/system/multi-user.target.wants/httpd.service
→ /usr/lib/systemd/system/httpd.service
```

This demonstrated how `systemd` enables the service for automatic startup.

## 5. Disabling a Service Without Stopping It

Apache was disabled using:

```bash
systemctl disable httpd
```

The status was then checked:

```bash
systemctl status httpd
```

The resulting state demonstrated:

```text
Loaded: ... disabled
Active: active (running)
```

Therefore:

```text
disable ≠ stop
```

`disable` prevents automatic startup at boot but does not stop a service that is currently running.


## 6. Enabled but Currently Stopped

The reverse state was also tested.

Apache was configured as enabled while remaining stopped:

```text
Loaded: ... enabled
Active: inactive (dead)
```

This demonstrated that boot configuration and current runtime state are independent:

```text
enabled  → configured to start automatically at boot
active   → running right now

disabled → not configured to start automatically at boot
inactive → not running right now
```

## 7. Restarting and Reloading Services

The following service operations were reviewed:

```bash
systemctl restart httpd
systemctl reload httpd
```

Their purposes are different:

```text
restart → stop the service and start it again
reload  → ask a running service to reload its configuration
```

Reloading can be useful after configuration changes when the service supports reloading without a complete restart.

## 8. Understanding Failed Services

A failed service was distinguished from an inactive service:

```text
inactive (dead) → service is currently stopped
failed          → service encountered a failure
```

The troubleshooting approach established during the lab was:

```text
Observe
   ↓
Diagnose
   ↓
Fix
   ↓
Verify
```

Instead of repeatedly restarting a failed service, its error information should be inspected first.

Apache configuration validation was also reviewed:

```bash
apachectl configtest
```

A valid Apache configuration reports:

```text
Syntax OK
```

## 9. Verifying Listening Network Services

Listening TCP sockets were inspected using:

```bash
ss -ltnp
```

The options were identified using the `ss` manual page:

```text
-l → show listening sockets
-t → show TCP sockets
-n → show numeric ports
-p → show the process using the socket
```

Apache was confirmed listening on TCP port 80 with the `httpd` process.

OpenSSH was also observed listening on TCP port 22 with the `sshd` process.

This provided an additional verification method:

```text
systemctl status <service>
        ↓
Is the service running?

ss -ltnp
        ↓
Is the expected process listening on the expected TCP port?
```

## 10. Reading Process Information

When Apache was running, `systemctl status httpd` displayed information including the Main PID, CGroup, and Apache processes.

After Apache was stopped and started again, a new Main PID was assigned.

This demonstrated that stopping a service terminates its running processes, while starting it creates new processes with new process IDs.

---

## CH09 Key Takeaways

- `systemd` manages services and other units on RHEL 9.
- `systemctl` controls and inspects systemd services.
- `systemctl status` displays the current service state.
- `start` starts a service now.
- `stop` stops a service now.
- `restart` stops and starts a service again.
- `reload` asks a running service to reload its configuration.
- `enable` configures automatic startup at boot.
- `disable` removes automatic startup at boot.
- `enable --now` enables and immediately starts a service.
- `active` and `enabled` describe different aspects of a service.
- `inactive` does not mean that the entire server is down.
- A `failed` service should be diagnosed before attempting random restarts.
- `ss -ltnp` verifies listening TCP ports and their processes.
- Apache HTTP Server uses the `httpd` service on RHEL.
- OpenSSH Server uses the `sshd` service.
- HTTP commonly uses TCP port 80.
- SSH commonly uses TCP port 22.

---

# Lab Completion

CH09 was completed through hands-on practice on a RHEL 9 virtual machine.

The lab covered service inspection, runtime service control, automatic startup, the distinction between runtime and boot states, basic failed-service troubleshooting, Apache service management, and independent verification of listening network services.

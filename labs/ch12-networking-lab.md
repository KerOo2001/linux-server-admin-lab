# CH12 - Managing Networking Lab

## Objective

Practice basic network configuration and troubleshooting on RHEL 9 using
NetworkManager, `nmcli`, `ip`, hostname tools, and local name resolution.

## Lab Environment

- OS: Red Hat Enterprise Linux 9
- Virtualization: VMware
- Primary interface: `ens160`
- Lab interface: `ens224`
- VMware LAN Segment: `RHEL-LAB`

## 1. Validate Current Network Configuration

Checked network interfaces:

```bash
ip addr
```

Checked the routing table:

```bash
ip route
```

Primary network configuration:

- Interface: `ens160`
- IPv4 address: `192.168.88.129/24`
- Default gateway: `192.168.88.2`
- Configuration method: DHCP

## 2. Inspect NetworkManager

Checked network devices and connection profiles:

```bash
nmcli device status
nmcli connection show
```

Verified the IPv4 configuration method of the primary connection:

```bash
nmcli -f ipv4.method connection show ens160
```

The primary connection used automatic IPv4 configuration:

```text
ipv4.method: auto
```

The current environment showed that the address was assigned through DHCP.

## 3. Create an Isolated VMware Lab Network

A second VMware network adapter was added to the RHEL virtual machine.

Network layout:

```text
ens160 -> VMware NAT -> Main network / Internet
ens224 -> RHEL-LAB LAN Segment -> Isolated lab network
```

The second adapter appeared in RHEL as:

```text
ens224
```

Initially, the device existed but had no active NetworkManager connection
profile.

This was verified using:

```bash
ip addr
nmcli device status
```

## 4. Create a Static NetworkManager Connection

Created a new NetworkManager connection profile named `lab-static`
and attached it to `ens224`:

```bash
nmcli connection add type ethernet \
  con-name lab-static \
  ifname ens224 \
  ipv4.method manual \
  ipv4.addresses 192.168.100.10/24
```

Verified the new connection:

```bash
nmcli connection show
nmcli device status
ip addr show ens224
```

Initial lab configuration:

```text
Connection: lab-static
Device:     ens224
IPv4:       192.168.100.10/24
Method:     manual
```

## 5. Validate the Routing Table

Checked the routing table:

```bash
ip route
```

The server contained the following important routes:

```text
default via 192.168.88.2 dev ens160
192.168.88.0/24 dev ens160
192.168.100.0/24 dev ens224
```

This showed that:

- `ens160` handled the main `192.168.88.0/24` network.
- `ens224` handled the isolated `192.168.100.0/24` lab network.
- The default gateway remained on `ens160`.
- No default gateway was configured on the isolated lab interface.

## 6. Deactivate and Activate a Connection

Deactivated the lab connection:

```bash
nmcli connection down lab-static
```

Checked the device state:

```bash
nmcli device status
```

`ens224` became disconnected because its connection profile was no longer
active.

Activated the profile again:

```bash
nmcli connection up lab-static
```

Verified the result:

```bash
nmcli device status
```

The device was connected again using the `lab-static` profile.

## 7. Modify the Static IPv4 Address

Changed the saved IPv4 address from:

```text
192.168.100.10/24
```

to:

```text
192.168.100.20/24
```

using:

```bash
nmcli connection modify lab-static ipv4.addresses 192.168.100.20/24
```

Immediately after modifying the profile, the active interface still showed
the previous address.

Checked using:

```bash
ip addr show ens224
```

The connection was then reactivated:

```bash
nmcli connection down lab-static
nmcli connection up lab-static
```

Verified the new address:

```bash
ip addr show ens224
```

The interface now used:

```text
192.168.100.20/24
```

Final NetworkManager configuration:

```text
connection.id:             lab-static
connection.interface-name: ens224
ipv4.method:               manual
ipv4.addresses:            192.168.100.20/24
```

## 8. Basic Network Troubleshooting

Basic network connectivity was tested using the following sequence:

```bash
ip addr
ip route
ping -c 4 192.168.88.2
ping -c 4 8.8.8.8
ping -c 4 google.com
```

These tests helped distinguish between:

- Interface/IP configuration problems
- Routing or gateway problems
- External connectivity problems
- DNS/name-resolution problems

The gateway, external IP, and hostname tests completed successfully.

## 9. Hostname Verification

Checked the current hostname:

```bash
hostname
```

Result:

```text
Server.kero
```

Displayed detailed hostname and system information:

```bash
hostnamectl
```

The static hostname was:

```text
Server.kero
```

## 10. Local Name Resolution

Inspected the local hosts file:

```bash
cat /etc/hosts
```

Added a local hostname mapping for the lab interface:

```bash
echo "192.168.100.20 lab-server" >> /etc/hosts
```

The resulting mapping was:

```text
192.168.100.20 lab-server
```

Tested local name resolution:

```bash
ping -c 2 lab-server
```

The hostname successfully resolved:

```text
lab-server -> 192.168.100.20
```

The ping test completed with `0% packet loss`.

## Final Lab Configuration

```text
RHEL Server
|
|-- ens160
|   |-- IPv4: 192.168.88.129/24
|   |-- Method: DHCP
|   |-- Gateway: 192.168.88.2
|   `-- Purpose: Main network / Internet
|
`-- ens224
    |-- Connection: lab-static
    |-- IPv4: 192.168.100.20/24
    |-- Method: Static / manual
    `-- Purpose: Isolated RHEL-LAB network
```

## Key Takeaways

- `ip addr` displays network interfaces and IP addresses.
- `ip route` displays the system routing table.
- `nmcli device status` displays NetworkManager device states.
- `nmcli connection show` displays NetworkManager connection profiles.
- A network device and a NetworkManager connection profile are different concepts.
- `ipv4.method auto` uses automatic IPv4 configuration.
- `ipv4.method manual` is used for static IPv4 configuration.
- `nmcli connection add` creates a connection profile.
- `nmcli connection modify` changes saved connection settings.
- Saved changes may require the connection to be reactivated before they appear on the active interface.
- `nmcli connection down/up` deactivates and activates a connection profile.
- `/etc/hosts` can provide local hostname-to-IP resolution.
- A separate VMware LAN Segment provides a safe isolated environment for networking practice.


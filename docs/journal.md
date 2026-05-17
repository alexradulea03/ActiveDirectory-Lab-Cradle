# Network Store Cache Corruption (PersistentStore)

The Issue: High-level PowerShell provisioning cmdlets failed to pass static configurations, throwing interface exceptions due to a corrupted network configurations store cache within the client image (AddressState: Invalid inside the PersistentStore).

The Resolution: Bypassed the damaged CIM provider layer using low-level Win32 network stack utilities. Leveraged the classic Network Shell (netsh) tool to forcefully bind the static IPv4 parameters and primary DNS settings directly onto the adapter alias

```
netsh interface ipv4 set address name="Ethernet" static 10.0.0.50 255.255.255.0 10.0.0.1

netsh interface ipv4 set dns name="Ethernet" static 10.0.0.10
```

# Kerberos Time Skew Mismatches

The Issue: Network communications and DNS routing were functional, yet domain joining failed with a cryptic The request is not supported block. System tracing proved the local time service (w32time) was unable to fetch NTP sync data from the DC due to implicit endpoint firewall filters.

The Resolution: Active Directory strictly enforces a maximum 5-minute time skew to mitigate replay attacks. The trust anchor was satisfied by updating the client's internal authentication metrics via the registry, matching the system date directly to the server's RPC file modifications, and using the underlying WMI fallback management array to complete the join pipeline:

```
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LmCompatibilityLevel" -Value 5 -Type DWord
```

# OS Edition Capabilities Constraint

The Issue: The Domain association toggle within the system core parameters (sysdm.cpl) was completely greyed out on the endpoint machine.

The Resolution: Identified that the base client image was running a restrictive Windows Home Edition, which completely strips out active directory network federation capabilities. Executed an in-place upgrade to Windows Pro over the command line using a staging orchestration key, fully exposing the required structural AD hooks without necessitating a complete OS reinstall.

```
Changepk.exe /ProductKey VK7JG-NPHTM-C97JM-9MPGT-3V66T
```

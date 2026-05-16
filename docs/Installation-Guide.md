# Installation & Configuration Guide (Client Deployment)

Follow these steps precisely to prepare and join a Windows client workstation to the `gatekeeper.local` domain environment.

### Step 1: Physical Virtualization Link
1. Power down the virtual machine.
2. In VirtualBox Settings, navigate to **Network**.
3. Set **Attached To** to `NAT Network`. Select your global lab network name.
4. Power on the machine.

### Step 2: System Capability Upgrade
Open **PowerShell as an Administrator** and execute the following to verify or force the operating system feature upgrade to Windows Pro:
```powershell
Changepk.exe /ProductKey VK7JG-NPHTM-C97JM-9MPGT-3V66T

### Step 3: Local Network Stack Init.

```
netsh interface ipv4 set address name="Ethernet" static 10.0.0.50 255.255.255.0 10.0.0.1
netsh interface ipv4 set dns name="Ethernet" static 10.0.0.10
```

### Step 4: System Domain Federation
Initialize the system properties box via Run (Windows Key + R -> sysdm.cpl).

Select Change...

Select Domain, input gatekeeper.local, and click OK.

Authenticate using the Domain Admin credential object:

User: GATEKEEPER\Administrator

Password: LabPassword2026!

Acknowledge the confirmation prompt and reboot the endpoint.
# 1. Set a static IP Address (matches our architecture blueprint)
$NetAdapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
New-NetIPAddress -InterfaceIndex $NetAdapter.InterfaceIndex -IPAddress "10.0.0.10" -PrefixLength 24 -DefaultGateway "10.0.0.1"
Set-DnsClientServerAddress -InterfaceIndex $NetAdapter.InterfaceIndex -ServerAddresses "127.0.0.1"

# 2. Rename the computer to a standardized naming convention
Rename-Computer -NewName "DC01" -Force

# 3. Install Active Directory Domain Services features
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Note: After running this script in your VM, you would execute the deployment 
# command below to promote the machine to a forest root:
# Install-ADDSForest -DomainName "gatekeeper.local" -ForestMode WinThreshold -DomainMode WinThreshold
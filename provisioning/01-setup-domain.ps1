# 1. Setting a static IP Address (matches our architecture blueprint)
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

# Core Active Directory Forest Deployment Script
# Optimized for Windows Server 2022 / VirtualBox 7.x

Write-Output "Configuring Static Network IP for Domain Controller..."
$NetAdapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
New-NetIPAddress -InterfaceIndex $NetAdapter.InterfaceIndex -IPAddress "10.0.0.10" -PrefixLength 24 -DefaultGateway "10.0.0.1" -Confirm:$false
Set-DnsClientServerAddress -InterfaceIndex $NetAdapter.InterfaceIndex -ServerAddresses "127.0.0.1"

Write-Output "Renaming system to DC01..."
Rename-Computer -NewName "DC01" -Force

Write-Output "Installing Active Directory Binaries..."
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Write-Output "Promoting server to Domain Controller..."
# Note: Using functional level 7 (Win2016) as it is natively supported by Server 2022
Install-ADDSForest -DomainName "gatekeeper.local" -ForestMode 7 -DomainMode 7 -Force:$true
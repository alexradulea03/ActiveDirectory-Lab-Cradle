# ==============================================================================
# Script: 04-join-domain.ps1
# Description: Configures client IP/DNS and joins the machine to gatekeeper.local
# Project: Gatekeeper Home Lab / GitHub Portfolio
# ==============================================================================

Write-Output "Configuring Static IP and Domain DNS for Client Workstation..."

# Find the active network adapter linked to the internal network
$NetAdapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}

# Assign Client01 the IP address 10.0.0.50 and point DNS directly to our DC (10.0.0.10)
New-NetIPAddress -InterfaceIndex $NetAdapter.InterfaceIndex -IPAddress "10.0.0.50" -PrefixLength 24 -DefaultGateway "10.0.0.1" -Confirm:$false
Set-DnsClientServerAddress -InterfaceIndex $NetAdapter.InterfaceIndex -ServerAddresses "10.0.0.10"

Write-Output "Network configured. Initiating Domain Join for gatekeeper.local..."

# Provide domain administrator credentials securely to execute the join operation
$DomainUser = "GATEKEEPER\Administrator"
$Password = ConvertTo-SecureString "LabPassword2026!" -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($DomainUser, $Password)

# Execute domain join and force a restart to apply changes
Add-Computer -DomainName "gatekeeper.local" -Credential $Credentials -Restart -Force
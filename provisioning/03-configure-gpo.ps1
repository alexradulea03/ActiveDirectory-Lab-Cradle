# ==============================================================================
# Script: 03-configure-gpo.ps1
# Description: Automates the creation and linking of Group Policy Objects (GPOs)
# Project: Gatekeeper Home Lab / GitHub Portfolio
# ==============================================================================

Import-Module GroupPolicy

$GPOName = "Sec_Block_CMD_and_Registry"
$DomainName = "gatekeeper.local"

# 1. Create the new GPO if it doesn't exist
if (-not (Get-GPO -Name $GPOName -ErrorAction SilentlyContinue)) {
    $NewGPO = New-GPO -Name $GPOName -Comment "Security baseline policy to restrict standard user tools."
    
    # 2. Configure the GPO Registry Setting to disable Command Prompt
    # Path inside GPO: User Configuration -> Administrative Templates -> System -> Prevent access to the command prompt
    $RegistryPath = "HKCU\Software\Policies\Microsoft\Windows\System"
    Set-GPRegistryValue -Name $GPOName -Key $RegistryPath -ValueName "DisableCMD" -Type DWord -Value 1
    
    Write-Host "Successfully created and configured GPO: $GPOName" -ForegroundColor Green
} else {
    Write-Host "GPO $GPOName already exists. Skipping creation..." -ForegroundColor Yellow
}

# 3. Link the GPO to our OUs (Targeting IT, Sales, and HR)
$TargetOUs = @("IT", "Sales", "HR")

foreach ($OU in $TargetOUs) {
    $OUPath = "OU=$OU,DC=gatekeeper,DC=local"
    
    # Link the GPO to the specific Organizational Unit
    New-GPLink -Name $GPOName -Target $OUPath -LinkEnabled Yes
    Write-Host "Linked $GPOName to $OU Organizational Unit." -ForegroundColor Green
}
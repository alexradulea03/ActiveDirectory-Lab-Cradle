# ==============================================================================
# Script: 02-provision-users.ps1
# Description: Automates OU creation and populates Active Directory with test users
# Project: Gatekeeper Home Lab / GitHub Portfolio
# ==============================================================================

# 1. Create Organizational Units (OUs) for business structure
$OUs = @("Management", "IT", "Sales", "HR")

foreach ($OU in $OUs) {
    $OUPath = "OU=$OU,DC=gatekeeper,DC=local"
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$OU'")) {
        New-ADOrganizationalUnit -Name $OU -Path "DC=gatekeeper,DC=local" -ProtectedFromAccidentalDeletion $false
        Write-Host "Successfully created OU: $OU" -ForegroundColor Green
    } else {
        Write-Host "OU $OU already exists. Skipping..." -ForegroundColor Yellow
    }
}

# 2. Mock Database: List of users to provision
$Users = @(
    @{ FirstName = "Sarah";  LastName = "Connor";  Username = "sconnor";  Department = "Management"; Title = "Director" }
    @{ FirstName = "John";   LastName = "Connor";  Username = "jconnor";  Department = "IT";         Title = "SysAdmin" }
    @{ FirstName = "Marcus"; LastName = "Wright";  Username = "mwright";  Department = "Sales";      Title = "Account Manager" }
    @{ FirstName = "Kyle";   LastName = "Reese";   Username = "kreese";   Department = "HR";         Title = "HR Generalist" }
)

# Default password for all lab users (Must meet complexity requirements)
$SecurePassword = ConvertTo-SecureString "LabPassword2026!" -AsPlainText -Force

# 3. Loop through the database and create users
foreach ($User in $Users) {
    $TargetOU = "OU=$($User.Department),DC=gatekeeper,DC=local"
    
    # Check if user already exists
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($User.Username)'")) {
        
        New-ADUser -Name "$($User.FirstName) $($User.LastName)" `
                   -SamAccountName $User.Username `
                   -UserPrincipalName "$($User.Username)@gatekeeper.local" `
                   -GivenName $User.FirstName `
                   -Surname $User.LastName `
                   -Title $User.Title `
                   -Department $User.Department `
                   -Path $TargetOU `
                   -AccountPassword $SecurePassword `
                   -Enabled $true `
                   -ChangePasswordAtLogon $false

        Write-Host "Provisioned User: $($User.Username) inside OU: $($User.Department)" -ForegroundColor Green
    } else {
        Write-Host "User $($User.Username) already exists. Skipping..." -ForegroundColor Yellow
    }
}
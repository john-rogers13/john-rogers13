<#
.SYNOPSIS
    This PowerShell script ensures convenience PIN for Windows 10 must be disabled.
.NOTES
    Author          : John Rogers
    LinkedIn        : linkedin.com/in/john-rogers13/
    GitHub          : github.com/john-rogers13
    Date Created    : 2025-02-20
    Last Modified   : 2025-02-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WWN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-CC-000370).ps1 
#>
# Define the registry path
$RegistryPath = "HKLM:\Software\Policies\Microsoft\Windows\System"

# Define the registry value
$ValueName = "AllowDomainPINLogon"
$ValueData = 0  # Disables convenience PIN sign-in

# Ensure the registry path exists
If (-Not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Type DWord

# Confirm the change
$UpdatedValue = Get-ItemProperty -Path $RegistryPath -Name $ValueName
Write-Output "$ValueName has been set to: $($UpdatedValue.AllowDomainPINLogon)"

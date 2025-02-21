<#
.SYNOPSIS
    This PowerShell script ensures Group Policy objects must be reprocessed even if they have not changed

.NOTES
    Author          : John Rogers
    LinkedIn        : linkedin.com/in/john-rogers13/
    GitHub          : github.com/john-rogers13
    Date Created    : 2025-02-20
    Last Modified   : 2025-02-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000090

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-CC-000090).ps1 
#>
# Define the registry path
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}"

# Define the registry value
$ValueName = "NoGPOListChanges"
$ValueData = 0  # Ensures policies are reprocessed even if unchanged

# Ensure the registry path exists
If (-Not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Type DWord

# Confirm the change
$UpdatedValue = Get-ItemProperty -Path $RegistryPath -Name $ValueName
Write-Output "$ValueName has been set to: $($UpdatedValue.NoGPOListChanges)"

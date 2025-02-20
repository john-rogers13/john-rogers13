<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : John Rogers
    LinkedIn        : linkedin.com/in/john-rogers13/
    GitHub          : github.com/john-rogers13
    Date Created    : 2025-02-20
    Last Modified   : 2026-02-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE
# Define the registry path and value
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$ValueName = "MaxSize"
$DesiredValue = 32768  # 32,768 KB

# Check if the registry path exists, if not, create it
if (!(Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Get the current value of the registry key (if it exists)
$CurrentValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName

# Update the registry value if it does not exist or is set too low
if ($null -eq $CurrentValue -or $CurrentValue -lt $DesiredValue) {
    Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Registry value updated: $RegistryPath\$ValueName set to $DesiredValue KB"
} else {
    Write-Output "Registry value already set correctly: $CurrentValue KB"
}

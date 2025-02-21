<#
.SYNOPSIS
    This PowerShell script ensures Kerberos encryption types must be configured to prevent the use of DES and RC4 encryption suites.
.NOTES
    Author          : John Rogers
    LinkedIn        : linkedin.com/in/john-rogers13/
    GitHub          : github.com/john-rogers13
    Date Created    : 2025-02-20
    Last Modified   : 2025-02-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000190

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-SO-000190).ps1 
#>
# Define registry path and values
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"
$ValueName = "SupportedEncryptionTypes"
$ValueData = 0x7ffffff8 # 2147483640
$ValueType = "DWORD"

# Check if registry path exists, create if not
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Apply the registry setting
Set-ItemProperty -Path $RegPath -Name $ValueName -Value $ValueData -Type $ValueType

# Confirm the change
$ConfiguredValue = Get-ItemProperty -Path $RegPath -Name $ValueName
Write-Output "Updated $ValueName to $($ConfiguredValue.$ValueName) at $RegPath"

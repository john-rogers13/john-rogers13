<#
.SYNOPSIS
    This PowerShell script configured to audit Object Access - Removable Storage failures.

.NOTES
    Author          : John Rogers
    LinkedIn        : linkedin.com/in/john-rogers13/
    GitHub          : github.com/john-rogers13
    Date Created    : 2025-02-20
    Last Modified   : 2025-02-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000085

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\(STIG-ID-WN10-AU-000085).ps1 
#>
# Check current audit policy settings
$CurrentSetting = auditpol /get /subcategory:"Removable Storage"

# Apply the policy if it's not already set
if ($CurrentSetting -notmatch "Failure") {
    Write-Output "Configuring 'Audit Removable Storage' for Failure events..."
    auditpol /set /subcategory:"Removable Storage" /failure:enable
    Write-Output "'Audit Removable Storage' set to log Failure events."
} else {
    Write-Output "'Audit Removable Storage' is already configured."
}

# Verify the change
auditpol /get /subcategory:"Removable Storage"

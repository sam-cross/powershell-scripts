#### See LICENCE.md
####

# Variables (CHANGE ME!)
$CMLocation = "C:\Program Files (x86)\ConfigMgr Console\bin\Microsoft.ConfigurationManagement.exe"

# Definitions
$scriptPath = $MyInvocation.MyCommand.Definition
$langMode = $ExecutionContext.SessionState.LanguageMode

Try {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isElevated = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
} catch {
    $isElevated = $false
}

# Check if correct language mode enabled
# Usually, an incorrect language mode means the script is NOT elevated, so we will try to relaunch anyway...
If ($langMode -eq "ConstrainedLanguage" -or $isElevated -eq $false) {
    Write-Warning "Check for elevation failed. Relaunching with elevated permissions..."

    Start-Process -Verb RunAs powershell.exe -ArgumentList "& '$($scriptPath)'"
    exit 0
}

# Start an administrator PowerShell session
Start-Process -Verb RunAs powershell

# Start AD Users and Computers
Start-Process -Verb RunAs $env:SystemRoot\system32\dsa.msc

# Start MECM
# Note: Sometimes this will not be the correct file path, as the config manager will be in a different location
#       If this is the case, just update the path below.
Start-Process -Verb RunAs "'$($CMLocation)'"

# Exit this session
exit 0
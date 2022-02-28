# Guide to Scripts

Sam's PowerShell script collection resides in this directory.

----

## Remove-Device-For-Imaging
Removes a device from Active Directory and SCCM in preparation for imaging. Accepts a machine name as an argument or prompts for one when running.

Where names end with a specific character (eg: X), this will be automatically appended. Change the character in the PS1 file.

> EG (providing machine name in launch command): `> ./Remove-Device-For-Imaging.ps1 1023456`

> EG (providing machine name while script runs): `> ./Remove-Device-For-Imaging.ps1`

## Launch-Admin-Apps
Launches SCCM, Active Directory Users and Computers management, and a helpful admin PowerShell window. No arguments required. Run as normal and the script will open a UAC prompt for admin credentials, or run as administrator.

> EG: `> ./Launch-Admin-Apps.ps1`

## Join-Sites
Run in an administrator PowerShell session to programmatically join both Active Directory and SCCM sites for administration. No arguments required, but this script MUST be launched from inside an elevated PowerShell session.

> EG: `> ./Join-Sites.ps1`

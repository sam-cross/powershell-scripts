# Guide to Scripts

Sam's PowerShell script collection resides in this directory.

----

## Remove-Device-For-Imaging
Removes a device from Active Directory and SCCM in preparation for imaging. Accepts an asset tag (without trailing X) as an argument or prompts for one when running.

> EG (providing asset tag in launch command): `> ./Remove-Device-For-Imaging.ps1 1023456`
> EG (providing asset tag while script runs): `> ./Remove-Device-For-Imaging.ps1`

## Launch-Admin-Apps
Launches SCCM, Active Directory Users and Computers management, and a helpful admin PowerShell window. No arguments required. Run as normal and the script will open a UAC prompt for admin credentials, or run as administrator.

> EG: `> ./Launch-Admin-Apps.ps1`

## Join-Sites
Run in an administrator PowerShell session to programmatically join the Council's Active Directory and SCCM sites, for administration. No arguments required, but this script MUST be launched from inside an elevated PowerShell session.

> EG: `> ./Join-Sites.ps1`
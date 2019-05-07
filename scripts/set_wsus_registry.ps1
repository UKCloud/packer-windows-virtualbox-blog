<#
.SYNOPSIS
  Configures the local machine for WSUS updates instead of Windows Updates.
 
 
.DESCRIPTION
  This script will create all the registry keys required to ensure that Windows Updates
  come from the specified WSUS server, and not from the internet. Usually, this will later
  be overwritten by Group Policy Objects once the machine is on the domain.
 
.INPUTS
  None.
 
.OUTPUTS
  None.
#>
 
Param (
  # The full URI to the WSUS server to use for this client.
  [String] $wsusServer = "http://wsus.example.local:8530",
 
  # The name of the  WSUS Group in which to place this client.
  [String] $wsusGroup = "Example.WsusGroup"
)
 
# Write-Host "Setting WSUS Registry Entries"
# $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
# New-ItemProperty -Path $regPath -Name "WUServer" -Value $wsusServer -PropertyType String -Force
# New-ItemProperty -Path $regPath -Name "WUStatusServer" -Value $wsusServer -PropertyType String -Force
# New-ItemProperty -Path $regPath -Name "TargetGroupEnabled" -Value 1 -PropertyType DWord -Force
# New-ItemProperty -Path $regPath -Name "TargetGroup" -Value $wsusGroup -PropertyType String -Force
 
 
# $regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
# New-ItemProperty -Path $regPath -Name "NoAutoUpdate" -Value 0 -PropertyType DWord -Force
# New-ItemProperty -Path $regPath -Name "AUOptions" -Value 3 -PropertyType DWord -Force
# New-ItemProperty -Path $regPath -Name "ScheduledInstallDay" -Value 0 -PropertyType DWord -Force
# New-ItemProperty -Path $regPath -Name "ScheduledInstallTime" -Value 3 -PropertyType DWord -Force
# New-ItemProperty -Path $regPath -Name "AutoInstallMinorUpdates" -Value 1 -PropertyType DWord -Force
# New-ItemProperty -Path $regPath -Name "UseWUServer" -Value 1 -PropertyType DWord -Force
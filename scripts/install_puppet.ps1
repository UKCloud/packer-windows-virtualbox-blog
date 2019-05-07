<#
.SYNOPSIS
  Installs the Puppet agent.
 
 
.DESCRIPTION
  Installs puppet agent from the internal repositories.
  By default, the agent is disabled and should be enabled when ready as part of deployment.
  This is because the hostname and puppet certs for this machine need to be made unique first.
 
.INPUTS
  None.
 
.OUTPUTS
  None.
#>
 
# Write-Host "Downloading Puppet agent..."
# Invoke-WebRequest -Uri "http://puppet.example.local/bin/puppet/agent/puppet-agent-x64-latest.msi" -OutFile "C:\Windows\Temp\puppet.msi"
# Write-Host "Installing Puppet agent..."
# Start-Process C:\Windows\System32\msiexec.exe -ArgumentList "/qb /i C:\Windows\Temp\puppet.msi /log C:\Windows\Temp\puppet.log" -Wait
# Write-Host "Making sure Puppet agent is disabled by default..."
# Set-Service -Name "puppet" -StartupType disabled
# Write-Host "Done installing Puppet agent."
$packerWindowsDir = 'C:\Windows\packer'
New-Item -Path $packerWindowsDir -ItemType Directory -Force
 
 
# final shutdown command
$shutdownCmd = @"
netsh advfirewall firewall set rule name="WinRM-HTTP" new action=block
 
C:/windows/system32/sysprep/sysprep.exe /generalize /oobe /unattend:C:/Windows/packer/unattended.xml /quiet /shutdown
"@
 
# unattend XML to run on first boot after sysprep
$unattendedXML = @"
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="generalize">
        <component name="Microsoft-Windows-Security-SPP" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <SkipRearm>0</SkipRearm>
        </component>
        <component name="Microsoft-Windows-PnpSysprep" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <PersistAllDeviceInstalls>true</PersistAllDeviceInstalls>
            <DoNotCleanUpNonPresentDevices>false</DoNotCleanUpNonPresentDevices>
        </component>
    </settings>
    <settings pass="oobeSystem">
        <component name="Microsoft-Windows-International-Core" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
          <InputLocale>0809:00000809</InputLocale>
          <SystemLocale>en-GB</SystemLocale>
          <UILanguage>en-US</UILanguage>
          <UserLocale>en-GB</UserLocale>
        </component>
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <OOBE>
                <HideEULAPage>true</HideEULAPage>
                <ProtectYourPC>1</ProtectYourPC>
                <NetworkLocation>Work</NetworkLocation>
                <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
            </OOBE>
            <RegisteredOrganization>ExampleOrg</RegisteredOrganization>
            <RegisteredOwner>ExampleUser</RegisteredOwner>
            <TimeZone>GMT Standard Time</TimeZone>
            <UserAccounts>
                <AdministratorPassword>
                    <Value>example_password</Value>
                    <PlainText>true</PlainText>
                </AdministratorPassword>
            </UserAccounts>
            <AutoLogon>
              <Enabled>false</Enabled>
            </AutoLogon>
        </component>
    </settings>
    <settings pass="specialize">
    </settings>
</unattend>
"@
 
Set-Content -Path "$($packerWindowsDir)\PackerShutdown.bat" -Value $shutdownCmd
Set-Content -Path "$($packerWindowsDir)\unattended.xml" -Value $unattendedXML
 
# will run on first boot
# https://technet.microsoft.com/en-us/library/cc766314(v=ws.10).aspx
$setupComplete = @"
netsh advfirewall firewall set rule name="WinRM-HTTP" new action=allow
"@
 
New-Item -Path 'C:\Windows\Setup\Scripts' -ItemType Directory -Force
Set-Content -path "C:\Windows\Setup\Scripts\SetupComplete.cmd" -Value $setupComplete
# Purpose
Currently, this set of scripts supports creating Azure Virtual Machines, installing commonly used development services and frameworks, and running builds.



# Scenarios

##Ionic

Folder *Boxstarter-Ionic* contains scripts using [Boxstarter](http://boxstarter.org/) to provision Azure VMs. It is required to
1. have Boxstarter Azure installed (easiest way is pointing Internet Explorer to [http://boxstarter.org/nr/boxstarter.azure](http://boxstarter.org/nr/boxstarter.azure) )
1. have an Azure subscription where you have administrative rights on it

### Creating an Azure VM capable of building Ionic projects
1. Open Azure Powershell
1. `Add-AzureAccount` to enter credentials for and connect to your Azure Account
1. `Set-AzureSubscription -SubscriptionId <YourSubscriptionID> -CurrentStorageAccountName <YourStorageAccountName>` to specify which environment to work with
1. `$cred=Get-Credential` opens a popup where you can specify credentials. This does **not** have to be a valid user on your computer. Rather, this is used to create a VM with these credentials
1. `New-AzureQuickVM -ServiceName <CloudServiceNameAsInManagementPortal> -Windows -Name <NameYourVMWhatever> -ImageName 3a50f22b388a4ff7ab41029918570fa6__Windows-Server-2012-Essentials-20141204-enus -Password $cred.GetNetworkCredential().Password -AdminUsername $cred.UserName -WaitForBoot -InstanceSize Basic_A2`

This will spin up a new Azure VM with the specified base image (you can use another image if you'd like). This line also uses the third smallest VM, not the smallest - A0 instances are painfully slow to work with if you RDP into them.

Once the VM has booted, use two packages to install all of the software.
As of now, you have to create packages from the supplied scripts first. This is only necessary when running for the first time or when a script changes. For the two following scripts, you'd need
`New-PackageFromScript .\Boxstarter-Ionic\DevCommon.ps1 DevCommon` and
`New-PackageFromScript .\Boxstarter-Ionic\DevIonic.ps1 DevIonic`

The following command will install these two packages on your VM
`"<NameYourVMWhatever>" | Enable-BoxstarterVM -Provider Azure -CloudServiceName <CloudServiceNameAsInManagementPortal> -Credential $cred | Install-BoxstarterPackage -PackageName "DevCommon", "DevIonic"`


### Running Ionic Builds on top of that VM

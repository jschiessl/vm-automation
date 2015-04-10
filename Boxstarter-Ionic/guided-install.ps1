#remove existing subs
If (Get-AzureSubscription) { Get-AzureSubscription | Remove-AzureSubscription -Force }

#auth
Write-Host "`n Authenticating to your Azure account" -ForegroundColor Cyan
Add-AzureAccount | Out-Null

# Select Subscription
Write-Host "`n Listing available Azure subscriptions:" -ForegroundColor Cyan
If (Get-AzureSubscription) { Get-AzureSubscription | Select SubscriptionName,SubscriptionId | FT } Else { Write-Host "`n FAILED: No subscriptions found`n" -fore red;Exit }
$selSub=Read-Host "`n Select SubscriptionID"
If (!(Get-AzureSubscription -SubscriptionId $selSub -ErrorAction SilentlyContinue)){ Write-Host "`n FAILED: Invalid SubscriptionId`n" -fore red;Exit }
Select-AzureSubscription -SubscriptionId $selSub | Out-Null

#select storage account
Write-Host "`n Listing available Storage Accounts:" -ForegroundColor Cyan
Get-AzureStorageAccount | Select StorageAccountName | FT
$san=Read-Host "`n Select Storage Account Name"
If (!(Get-AzureStorageAccount -StorageAccountName $san -ErrorAction SilentlyContinue)){ Write-Host "`n FAILED: Invalid Storage Account Name`n" -fore red;Exit }

Set-AzureSubscription -SubscriptionId $selSub -CurrentStorageAccountName $san

Write-Host "`n Please enter desired admin username and password for your new VM"
$cred=Get-Credential

$vmName=Read-Host "`n Please give your VM a name"

Write-Host "`n Listing available Cloud Services:" -ForegroundColor Cyan
If (Get-AzureService) { Get-AzureService | Select ServiceName,Location | FT } Else { Write-Host "`n FAILED: No cloud services found`n" -fore red;Exit }

$cloudServiceName=Read-Host "`n Please enter the name of an existing cloud service you would like the VM to be added to"

Write-Host "Now creating your new VM and waiting for it to boot. This will take a few minutes" -ForegroundColor Cyan
New-AzureQuickVM -ServiceName $cloudServiceName -Windows -Name $vmName -ImageName 3a50f22b388a4ff7ab41029918570fa6__Windows-Server-2012-Essentials-20141204-enus -Password $cred.GetNetworkCredential().Password -AdminUsername $cred.UserName -WaitForBoot -InstanceSize Basic_A2

Write-Host "VM is ready. Now installing packages DevCommon and DevIonic" -ForegroundColor Cyan
$vmName | Enable-BoxstarterVM -Provider Azure -CloudServiceName $cloudServiceName -Credential $cred | Install-BoxstarterPackage -PackageName "DevCommon", "DevIonic"

Write-Host "Done. Everything should be set up." -ForegroundColor Cyan

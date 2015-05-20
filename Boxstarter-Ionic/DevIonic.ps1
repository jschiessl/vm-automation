#Ionic
cinst android-sdk
Write-BoxstarterMessage "Installed Android SDK"

if ($env:ANDROID_HOME -eq $null){
  Write-BoxstarterMessage "Android_Home environment variable was not found, setting it"
  [Environment]::SetEnvironmentVariable("ANDROID_HOME", "$env:localappdata\Android\sdk\", "Machine")
}

cd $env:LOCALAPPDATA\Android\android-sdk\tools

echo "yes" | .\android update sdk --no-ui --all --filter tools
echo "yes" | .\android update sdk --no-ui --all --filter platform-tools
echo "yes" | .\android update sdk --no-ui --all --filter build-tools-19.1.0
echo "yes" | .\android update sdk --no-ui --all --filter build-tools-20.0.0
echo "yes" | .\android update sdk --no-ui --all --filter build-tools-21.1.2
echo "yes" | .\android update sdk --no-ui --all --filter build-tools-22.0.0
Write-BoxstarterMessage "Installed Android Build Tools"

echo "yes" | .\android update sdk --no-ui --all --filter android-19
echo "yes" | .\android update sdk --no-ui --all --filter android-20
echo "yes" | .\android update sdk --no-ui --all --filter android-21
echo "yes" | .\android update sdk --no-ui --all --filter android-22
Write-BoxstarterMessage "Installed Android Targets"

#Install-ChocolateyPath $env:localappdata\Android\android-sdk\tools 'Machine'
#Install-ChocolateyPath $env:localappdata\Android\android-sdk\platform-tools 'Machine'

npm install -g --loglevel silent ionic cordova
Write-BoxstarterMessage "Installed Ionic and Cordova"

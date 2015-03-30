#Ionic
cinst android-sdk
Write-BoxstarterMessage "Installed Android SDK"

cd $env:LOCALAPPDATA\Android\android-sdk\tools

echo "yes" | .\android update sdk --no-ui --all --filter tools
echo "yes" | .\android update sdk --no-ui --all --filter platform-tools
echo "yes" | .\android update sdk --no-ui --all --filter build-tools-19.1.0
echo "yes" | .\android update sdk --no-ui --all --filter build-tools-20.0.0
echo "yes" | .\android update sdk --no-ui --all --filter build-tools-21.1.2
Write-BoxstarterMessage "Installed Android Build Tools"

echo "yes" | .\android update sdk --no-ui --all --filter android-19
echo "yes" | .\android update sdk --no-ui --all --filter android-20
echo "yes" | .\android update sdk --no-ui --all --filter android-21
Write-BoxstarterMessage "Installed Android Targets"

#Install-ChocolateyPath $env:localappdata\Android\android-sdk\tools 'Machine'
#Install-ChocolateyPath $env:localappdata\Android\android-sdk\platform-tools 'Machine'

npm install -g --loglevel silent ionic cordova
Write-BoxstarterMessage "Installed Ionic and Cordova"
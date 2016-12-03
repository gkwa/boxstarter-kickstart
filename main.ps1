Set-PSDebug -Trace 2


powershell -noninteractive -noprofile -executionpolicy unrestricted -command "(new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/wget.exe','wget.exe')"
# wget --no-verbose --timestamping --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/boxstarter-kickstart/tm/wip/WindowsUpdateLoop.xml

wget --no-verbose --timestamping --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/win_settings/master/settings.ps1 
wget --no-verbose --timestamping --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/win_settings/master/include.ps1

wget --no-verbose --timestamping --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/boxstarter-kickstart/tm/wip/boxstarter_bootstrap.ps1
wget --no-verbose --timestamping --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/boxstarter-kickstart/tm/wip/update.ps1

powershell --timestampingoProfile -ExecutionPolicy Bypass -file settings.ps1 --proxydisable
powershell -noninteractive -noprofile -executionpolicy unrestricted -inputformat none -file boxstarter_bootstrap.ps1

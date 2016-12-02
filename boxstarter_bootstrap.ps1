update-executionpolicy unrestricted


if(-not(test-path $env:appdata\Roaming\Boxstarter))
{
	mkdir -force c:\windows\setup
	cd \windows\setup
	powershell -noninteractive -noprofile -executionpolicy unrestricted -command "(new-object System.Net.WebClient).DownloadFile('http://boxstarter.org/downloads/Boxstarter.2.8.29.zip','Boxstarter.zip')"
	powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/7za.exe','7za.exe')"
	wget -nv -N --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/boxstarter-kickstart/tm/wip/update.ps1 -O c:\windows\setup\update.ps1
	.\7za.exe x -y -obs Boxstarter.zip
	cd bs
	cmd /c setup.bat -force
}

schtasks /delete /f /tn WindowsUpdateLoop
schtasks /f /ru "NT Authority\System" /Create /xml WindowsUpdateLoop.xml /tn WindowsUpdateLoop
if(!(test-path "$env:appdata\Boxstarter\BoxstarterShell.ps1"))
{
	mkdir -force c:\windows\setup | out-null
	cd \windows\setup
	powershell -noninteractive -noprofile -executionpolicy unrestricted -command "(new-object System.Net.WebClient).DownloadFile('http://boxstarter.org/downloads/Boxstarter.2.8.29.zip','Boxstarter.zip')"
	powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/7za.exe','7za.exe')"

# FIXME: Github doesn't support timestamps
#	wget -nv -N --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/boxstarter-kickstart/tm/wip/update.ps1 -O c:\windows\setup\update.ps1
	wget -nv -N --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/boxstarter-kickstart/tm/wip/update.ps1 -O c:\windows\setup\update.ps1
	.\7za.exe x -y -obs Boxstarter.zip
	cd bs
	cmd /c setup.bat -force
	shutdown -t 0 -r -f
}

. "$env:appdata\Boxstarter\BoxstarterShell.ps1"

update-executionpolicy unrestricted

$Boxstarter.RebootOK=$true

install-windowsupdate -accepteula -suppressreboot
if(test-pendingreboot)
{
	invoke-reboot
}

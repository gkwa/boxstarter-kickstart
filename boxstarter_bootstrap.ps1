Set-PSDebug -Trace 2

mkdir -force c:\windows\setup | out-null
cd \windows\setup

schtasks /delete /f /tn WindowsUpdateLoop
schtasks /delete /f /tn boxstarter
schtasks /create /sc onlogon /tn boxstarter /tr "cmd /c start /d %windir%\setup cmd /c C:\windows\system32\WindowsPowerShell\v1.0\powershell.exe -file update.ps1"

if(-not(test-path $env:appdata\Roaming\Boxstarter))
{
	powershell -noninteractive -noprofile -executionpolicy unrestricted -command "(new-object System.Net.WebClient).DownloadFile('http://boxstarter.org/downloads/Boxstarter.2.8.29.zip','Boxstarter.zip')"
	powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/7za.exe','7za.exe')"
	wget -nv -N --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/boxstarter-kickstart/tm/wip/update.ps1 -O c:\windows\setup\update.ps1
	.\7za.exe x -y -obs Boxstarter.zip
	cd bs
    shutdown -t 0 -r -f
}
cmd /c setup.bat -force
shutdown -t 0 -r -f

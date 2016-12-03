Function Write-Log {
    [CmdletBinding()]
    Param(
    [Parameter(Mandatory=$False)]
    [ValidateSet("INFO","WARN","ERROR","FATAL","DEBUG")]
    [String]
    $Level = "INFO",

    [Parameter(Mandatory=$True)]
    [string]
    $Message,

    [Parameter(Mandatory=$False)]
    [string]
    $logfile
    )

    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $Line = "$Stamp $Level $Message"
    If($logfile) {
        Add-Content $logfile -Value $Line
    }
    Else {
        Write-Output $Line
    }
}

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

Set-PSDebug -Trace 2

. "$env:appdata\Boxstarter\BoxstarterShell.ps1"

update-executionpolicy unrestricted

$Boxstarter.RebootOK=$true
$Boxstarter.AutoLogin=$true
$Boxstarter.SuppressLogging=$false

while(1)
{

	# logs go here by default
	# $env:LocalAppData\Boxstarter\Boxstarter.log

	$result = install-windowsupdate -accepteula -verbose
#	write-host "$result"
#	Write-Log -level INFO -message "[$result]" -logfile "c:\windows\setup\wu.log"

	if(test-pendingreboot)
	{
		shutdown -t 0 -r -f
	}

	sleep -s 30
}
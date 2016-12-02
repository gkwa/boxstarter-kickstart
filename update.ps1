. "$env:appdata\Boxstarter\BoxstarterShell.ps1"

update-executionpolicy unrestricted

$Boxstarter.RebootOK=$true

install-windowsupdate -accepteula -suppressreboot
if(test-pendingreboot)
{
	invoke-reboot
}

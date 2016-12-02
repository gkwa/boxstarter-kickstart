. "$env:appdata\Boxstarter\BoxstarterShell.ps1"

$Boxstarter.RebootOK=$true

install-windowsupdate -accepteula -suppressreboot
if(test-pendingreboot)
{
	invoke-reboot
}

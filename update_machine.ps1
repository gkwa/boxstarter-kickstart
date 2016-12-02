if(-not(test-path $env:appdata\Roaming\Boxstarter)){
set-location c:\
mkdir c:\windows\setup
cd \windows\setup

powershell -noninteractive -noprofile -executionpolicy unrestricted -command "(new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/wget.exe','wget.exe')"
powershell -noninteractive -noprofile -executionpolicy unrestricted -command "(new-object System.Net.WebClient).DownloadFile('http://boxstarter.org/downloads/Boxstarter.2.8.29.zip','Boxstarter.zip')"
powershell -NoProfile -ExecutionPolicy unrestricted -Command "(new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/7za.exe','7za.exe')"
7za.exe x -y -obs Boxstarter.zip
cd bs
setup.bat -force

}


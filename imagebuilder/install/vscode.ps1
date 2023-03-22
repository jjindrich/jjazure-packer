#Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Write-Host "JJ Starting script"

#Install VSCode
Write-Host "Install VSCode"
Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?Linkid=852157' -OutFile 'c:\temp\VScode.exe'
Invoke-Expression -Command 'c:\temp\VScode.exe /verysilent'

Write-Host "JJ Finishing script"
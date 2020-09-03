#Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Write-Host "JJ Starting script"

#Create temp folder
New-Item -Path 'C:\temp' -ItemType Directory -Force | Out-Null

#Install VSCode
Write-Host "Install VSCode"
Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?Linkid=852157' -OutFile 'c:\temp\VScode.exe'
Invoke-Expression -Command 'c:\temp\VScode.exe /verysilent'

#Start sleep
Start-Sleep -Seconds 10

#Place file on Desktop
Write-Host "Modify Desktop"
Copy-Item -Path packer-wvd/welcome.txt -Destination c:\Users\Public\Desktop\welcome.txt

Write-Host "JJ Finishing script"
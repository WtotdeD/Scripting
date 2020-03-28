Powershell:
New-PSDrive -Name "P" -persist -PSProvider "FileSystem" -Root "\\WSAE000098.eu.rabonet.com"

New-PSDrive -Name "P" -persist -PSProvider "FileSystem" -Root "\\eurv150001\transfer$\dijkwe"


Set-WinUserLanguageList -LanguageList "en-US"

PS C:\Windows\security> Get-LocalGroupMember -Group "Power Users"
PS C:\Windows\security> Add-LocalGroupMember -Group "Administrators" -Member "RABONETEU\eu.res.SYSRFGD.RDM.ITDataDevOps.ls"


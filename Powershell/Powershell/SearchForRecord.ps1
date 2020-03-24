# Export one unique arrangement and the belonging source identifier and export them two files
## Defining classes
cls
$Ido = @( ,5189781698266)
    
$ReportingPeriod   ="201809"
$InputDirectory    ="K:\Ontwikkeling\IRCM ABB\Deployment_ABB\Bronbestanden"
$OutputDirectory   = "C:\Users\dijkwe.eu\Downloads\"
$NaamSource        ="\Import_Source_Identifiers_"
$NaamIRB           ="\Import_Arrangements_IRB_"
$Extension         =".csv"

$path        = ($InputDirectory,$NaamIRB,$ReportingPeriod,$extension) -join,""
$Outpath     = ($OutputDirectory,$NaamIRB,$ReportingPeriod,$extension) -join,""

$pathSource  = ($InputDirectory,$NaamSource,$ReportingPeriod,$extension) -join,""
$OutSource  = ($OutputDirectory,$NaamSource,$ReportingPeriod,$extension) -join,""


#Export
Get-Content -path $path | Select-String -Pattern "\b$Ido\b" | set-Content -path "$Outpath"

#Source Identifier
Get-Content -path $pathSource | Select-String -Pattern "\b$Ido\b"  | Set-Content -path "$OutSource"



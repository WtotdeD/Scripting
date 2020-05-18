
# install all the windows features used at my $home environment

$windowsfeatures = choco list -source windowsfeatures

$windowsfeatures | ForEach-Object { 
   
    $line = "choco windowsfeatures "

    if ($_ -match "\| Enabled") {
        
        $line += $_ -replace " {0,1}\|.*", ""
        $line
    }
} |  Out-File C:\Code\Scripting\Environment\ChocoInstallPackagesScriptWindowsfeatures.ps1

# List all local installed packages used in my $home environment

S | Out-File C:\Code\Scripting\Environment\ChocoInstallPackagesScript.ps1


## Install webpi

<#

$webpi = choco list -source webpi
$gotAll = 0
$start = 0;

$webpi | ForEach-Object { 

    if ($_ -contains "--Available Products") {
        $gotAll = 1;
    }
            
    if ($_ -eq "----------------------------------------") {
        $start = 1;
    }

    $line = "choco webpi "

    if ($start -eq 1 -and $gotAll -eq 0 -and $_ -ne "" -and $_ -ne "    " -and $_ -ne "----------------------------------------") {
        
        $line += $_ -replace " .*", ""
        $line
    }
}

#>
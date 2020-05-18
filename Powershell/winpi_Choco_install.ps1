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
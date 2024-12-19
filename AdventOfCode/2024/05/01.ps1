Add-Type -AssemblyName System.Windows.Forms
start-process msedge https://adventofcode.com/2024/day/5/input
start-sleep -s 5
[System.Windows.Forms.SendKeys]::SendWait("^a")
[System.Windows.Forms.SendKeys]::SendWait("^c")
$lists=Get-Clipboard

$i=0
$checklines=@()
$rules=@()
foreach($line in $lists){
    if($line -like "*|*"){
        $rules+=@([PSCustomObject]@{
            left = $line.split("|")[0]
            right = $line.split("|")[1]
        })
        $i++
    }
    if($line -like "*,*"){
        $checklines+=@($line)
        
    }
}

$xc=0
foreach($checkline in $checklines){
    $x=0
    $checklinea=$checkline.split(",")
    $nc=$checklinea.split(",").count
    for($i=0;$i -le $nc-2;$i++){
        $rulecheck=$rules|Where-Object{$_.left -eq $checklinea[$i] -and $_.right -eq $checklinea[$i+1]}       
        if(!$rulecheck){
            $x=$nc
         }
    }
    if($x -lt $nc){
        $xc+=$checklinea[($nc-1)/2]    
     }
}
$xc

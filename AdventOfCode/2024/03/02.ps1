Add-Type -AssemblyName System.Windows.Forms
start-process msedge https://adventofcode.com/2024/day/3/input
start-sleep -s 5
[System.Windows.Forms.SendKeys]::SendWait("^a")
[System.Windows.Forms.SendKeys]::SendWait("^c")
$lists=Get-Clipboard

$lists|%{
    $listall+=$_
}

$muls=$listall |Select-String -pattern  'mul\(\d{1,3},\d{1,3}\)' -AllMatches 
$dont=$listall |Select-String -pattern  "don\'t\(\)" -AllMatches 
$do=$listall |Select-String -pattern  "do\(\)" -AllMatches 

$summuls=0
$x=1
$lens=($muls.matches.index|measure-Object -Maximum).Maximum
#$lens=($lists|Out-String).length
for($i=1;$i -le $lens+1;$i++){
   
    if(($i-1) -in $dont.matches.index){
       $x=0
    }    
    
    if(($i-1) -in $do.matches.index){
        $x=1
    }
    
    if(($i-1) -in $muls.matches.index){
       $indexm=($muls.matches.index).indexof($i-1)
       $mulline= ($muls.matches.value)[$indexm]
       $extracs=$mulline |Select-String -pattern  '\d{1,3}' -AllMatches
       $summuls+= [int64](($extracs.Matches.Value)[0])*[int64](($extracs.Matches.Value)[1])*$x
     
       write-host "$i, $indexm, $x, $mulline, $summuls "
    
    }
    

}

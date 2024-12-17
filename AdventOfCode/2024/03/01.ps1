Add-Type -AssemblyName System.Windows.Forms
start-process msedge https://adventofcode.com/2024/day/2/input
start-sleep -s 5
[System.Windows.Forms.SendKeys]::SendWait("^a")
[System.Windows.Forms.SendKeys]::SendWait("^c")
$lists=Get-Clipboard
$muls=$lists |Select-String -pattern  'mul\(\d{1,3},\d{1,3}\)' -AllMatches


$summuls=0
foreach($matches1 in $muls.Matches.Value){
    $extracs=$matches1 |Select-String -pattern  '\d{1,3}' -AllMatches
   $summuls+= [int64](($extracs.Matches.Value)[0])*[int64](($extracs.Matches.Value)[1])
   
}
$summuls

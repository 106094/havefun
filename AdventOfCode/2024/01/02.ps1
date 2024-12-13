Add-Type -AssemblyName System.Windows.Forms
start-process msedge https://adventofcode.com/2024/day/1/input
start-sleep -s 5
[System.Windows.Forms.SendKeys]::SendWait("^a")
[System.Windows.Forms.SendKeys]::SendWait("^c")
$lists=Get-Clipboard
start-sleep -s 5
$ranks=$lists.split(" ")|Where-Object{[int32]$_ -ne "0"}
$i=1
$a=$b=@()
foreach($rank in $ranks){
    if($i % 2 -ne 0){
        $a+=@($rank)
    }
    else{
        $b+=@($rank)
    }
    $i++
}
$x=0
ForEach($a1 in $a){
$x+=[int64]$a1*(($b|Where-Object{$_ -eq $a1}).count)
}
$x

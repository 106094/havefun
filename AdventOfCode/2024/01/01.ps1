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
0..($a.count -1 )|ForEach-Object{
    $b1=$b|Sort-Object {[int32]$_}|Select-Object -Index $_
    $a1=$a|Sort-Object {[int32]$_}|Select-Object -Index $_
      $x+=[math]::Abs($b1-$a1)
    
}
$x

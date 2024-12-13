Add-Type -AssemblyName System.Windows.Forms
start-process msedge https://adventofcode.com/2024/day/2/input
start-sleep -s 5
[System.Windows.Forms.SendKeys]::SendWait("^a")
[System.Windows.Forms.SendKeys]::SendWait("^c")
$lists=Get-Clipboard
start-sleep -s 5
$i=0
$listsafe=@()
foreach($list in $lists){
    $numbers=$list.split(" ")
    $x=0
    ForEach($num in $numbers){
        $diff=([int32]($numbers[$x+1])-[int32]($numbers[$x]))
        if([int32]($numbers[$x+1]) -gt [int32]($numbers[$x]) -and $diff -ge 1 -and  $diff -le 3){
         if($x -eq ($numbers.count-2)){
            $i++
            $listsafe+=@($list)
            break
         }
        }
        else{
            break
        }
        $x++
    }
    
}

foreach($list in $lists){
    $numbers=$list.split(" ")
    $x=0
    ForEach($num in $numbers){
        $diff=([int32]($numbers[$x])-[int32]($numbers[$x+1]))
        if([int32]($numbers[$x+1]) -lt [int32]($numbers[$x]) -and $diff -ge 1 -and  $diff -le 3){
         if($x -eq ($numbers.count-2)){
            $i++
            $listsafe+=@($list)
            break
         }
        }
        else{
            break
        }
        $x++
    }
    
}

$i

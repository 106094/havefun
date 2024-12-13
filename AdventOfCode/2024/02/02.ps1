Add-Type -AssemblyName System.Windows.Forms
start-process msedge https://adventofcode.com/2024/day/2/input
start-sleep -s 5
[System.Windows.Forms.SendKeys]::SendWait("^a")
[System.Windows.Forms.SendKeys]::SendWait("^c")
$lists=Get-Clipboard
start-sleep -s 5
$i=0
$listsafe=@()
$listsafe2=@()
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

$newlist=$lists|Where-Object {$_ -notin  $listsafe}
foreach($list in $newlist){
    $numbers=$list.split(" ")
    $x=0
    $act=0
    ForEach($num in $numbers){
        $p1=[int32]($numbers[$x+1])
        $p2=[int32]($numbers[$x])
        $diff=$p1-$p2
        if(!($p1 -gt $p2 -and $diff -ge 1 -and  $diff -le 3) -and $act -eq 0){
            $p1=[int32]($numbers[$x+2])
            $p2=[int32]($numbers[$x])
            if($x -eq 0){
            $p2=[int32]($numbers[$x+1])
            }
            if($x -eq ($numbers.count-2)){
                Write-Host "check 69"
                start-sleep -s 200
            }
            $diff=$p1-$p2
          if(($p1 -gt $p2 -and $diff -ge 1 -and  $diff -le 3 )){
            $act=1
            $remove=$($numbers[$x])
            if($x -ne 0){
                $remove=$($numbers[$x+1])
                $x=$x+1 
            }
          }
        }
        if(($p1 -gt $p2 -and $diff -ge 1 -and  $diff -le 3) -and $act -eq 1){      
            if($x -eq ($numbers.count-2)){
                $i++
                $listsafe2+=@($list)
                write-host "remove $remove from $list"   
                break         
            }
        }
        else{
            break
        }

        $x++
    }
}

foreach($list in $newlist){
    $numbers=$list.split(" ")
    $x=0
    $act=0
    ForEach($num in $numbers){
        $p2=[int32]($numbers[$x+1])
        $p1=[int32]($numbers[$x])
        $diff=$p1-$p2
        if(!($p1 -gt $p2 -and $diff -ge 1 -and  $diff -le 3) -and $act -eq 0){
            $p2=[int32]($numbers[$x+2])
            $p1=[int32]($numbers[$x])
            if($x -eq 0){
            $p1=[int32]($numbers[$x+1])
            }
            $diff=$p1-$p2
          if(($p1 -gt $p2 -and $diff -ge 1 -and  $diff -le 3 )){
            $act=1
            $remove=$($numbers[$x])
            if($x -ne 0){
                $remove=$($numbers[$x+1])
                $x=$x+1 
            }
          }
        }
        if(($p1 -gt $p2 -and $diff -ge 1 -and  $diff -le 3) -and $act -eq 1){      
            if($x -eq ($numbers.count-2)){
                $i++
                $listsafe2+=@($list)
                write-host "remove $remove from $list"   
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


$newlist2=$lists|Where-Object {$_ -notin  $listsafe -and $_ -notin  $listsafe2}

Add-Type -AssemblyName System.Windows.Forms
start-process msedge https://adventofcode.com/2024/day/4/input
start-sleep -s 5
[System.Windows.Forms.SendKeys]::SendWait("^a")
[System.Windows.Forms.SendKeys]::SendWait("^c")
$lists=Get-Clipboard


$xc=0
  for($row=1;$row -lt $lists.count-1;$row++){
    for($i=1;$i -lt $line.length-1;$i++){       
        $line=$lists[$row]
        if($line[$i] -eq "A"){          
          $x1=($lists[$row-1]).substring($i-1,1)
          $x2=($lists[$row-1]).substring($i+1,1)
          $x3=($lists[$row+1]).substring($i-1,1)
          $x4=($lists[$row+1]).substring($i+1,1)
          $masx1=$x1 -match "[MS]"
          $masx2=$x2 -match "[MS]"
          $masx3=$x3 -match "[MS]" -and $x3 -ne $x2
          $masx4=$x4 -match "[MS]" -and $x4 -ne $x1
          if ($masx1 -and $masx2 -and $masx3 -and $masx4){
             $xc+=1
             #Write-Output "$row, $i"
          }
          
        }
    }
   }
   $xc

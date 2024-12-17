Add-Type -AssemblyName System.Windows.Forms
start-process msedge https://adventofcode.com/2024/day/4/input
start-sleep -s 5
[System.Windows.Forms.SendKeys]::SendWait("^a")
[System.Windows.Forms.SendKeys]::SendWait("^c")
$lists=Get-Clipboard

#forword
function findXMAS([string[]]$lists){
$xc=0
foreach($line in $lists){
    $xmax=$line|Select-String -Pattern "XMAS" -AllMatches
    $xc+=$xmax.Matches.Value.count
    
    $newline=""
    for($lc=$line.length-1;$lc -ge 0;$lc--){
    $newline+= $line[$lc]
    }
    
    $xmax=$newline|Select-String -Pattern "XMAS" -AllMatches
    $xc+=$xmax.Matches.Value.count
    
}
$xc
}



$cross1=@()
for($lc=0;$lc -le ($lists.count -1)*2;$lc++){
    $i=$lc
    $j=0
    $newlinec=""
     while($i -le $lc -and $j -le $lc){
        try{
        $newlinec+=($lists[$i]).Substring($j,1)
        }
        catch{
           $null
        }       
     $i--
     $j++
     }

     $cross1+=@($newlinec)
    }

$cross2=@()
for($lc=0;$lc -le ($lists.count -1)*2;$lc++){    
    $i=$lc
    $j=0
    $newlinec=""
     while($i -le $lc -and $j -le $lc){
    try{
        $newlinec+=($lists[$i]).Substring(($lists.count -1)-$j,1)
    }catch{
        $null
    }
         
     $i--
     $j++
     }

     $cross2+=@($newlinec)
    }



    $buttons=@()
    for($lc=0;$lc -le $lists.count-1;$lc++){       
        $i=$lc
        $j=0
        $newlinec=""
         while($i -le $lc -and $j -le ($lists.count)-1){
            try{
            $newlinec+=($lists[$j]).Substring($i,1)
            }
            catch{
                $null
            }       
            $j++
         }
    
         $buttons+=@($newlinec)
        }


    $countx=0
    $countx=findXMAS -lists $lists
    $countx
    $countx+=findXMAS -lists $cross1
    $countx
    $countx+=findXMAS -lists $cross2
    $countx
    $countx+=findXMAS -lists $buttons
    $countx

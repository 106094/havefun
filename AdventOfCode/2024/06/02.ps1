
 Add-Type -AssemblyName System.Windows.Forms
 start-process msedge https://adventofcode.com/2024/day/6/input
 start-sleep -s 5
 [System.Windows.Forms.SendKeys]::SendWait("^a")
 [System.Windows.Forms.SendKeys]::SendWait("^c")
 $lists=Get-Clipboard
 $linecount=$lists.count
 $dim=$lists[0].length 

 
function checkloop([string]$flag,[int32]$x,[int32]$y){
    $n=0
    $global:arrayg=@()
while($x -ge 0 -and $x -lt $linecount -and $y -ge 0 -and $y -lt $dim){
   $paths="$flag|$($x)|$($y)"
    #$paths
  if( $paths -in $global:arrayg ){
    $x=$linecount
    $n=1
  }
else{
    if($global:arrayg){
    $x0=($global:arrayg[-1].split("|"))[1]
    $y0=($global:arrayg[-1].split("|"))[2]
    if($x -eq $x0 -and $y -eq $y0){
        $global:arrayg[-1]=$paths
    }
    else{
        $global:arrayg+=@($paths)
    }
   }
   else{
    $global:arrayg+=@($paths)
   }
       
 if($flag -eq "v"){
    if($array1[(([int32]$x)+1),([int32]$y)] -eq "#"){     
        $flag="<"
    }else{
        $x++
    }
  }
  elseif($flag -eq "<"){
    if($array1[([int32]$x),($(([int32]$y)-1))] -eq "#"){        
        $flag="^"
    }else{
        $y--      
    }
  }
  elseif($flag -eq "^" ){
    if($array1[(([int32]$x)-1),([int32]$y)] -eq "#"){        
        $flag=">"
    }else{
        $x--
    }
  }
  elseif($flag -eq ">"){
    if($array1[([int32]$x),(([int32]$y)+1)] -eq "#"){       
      $flag= "v"
    }else{        
       $y++ 

    }
   }
  
}
}
$n
}

 
$flag="^"
$arrayx = New-Object 'object[,]' $linecount,$dim

for($i=0; $i -lt $linecount; $i++){
   for($j=0; $j -lt $dim; $j++){
    $arrayx[$i,$j]=($lists[$i]).Substring($j,1)
         if(($arrayx[$i,$j]) -eq $flag){
           $x0=$i
           $y0=$j
           $arrayx[$i,$j]="."
       }
   }
  
}

$array1=$arrayx
checkloop -flag "^" -x $x0 -y $y0
$iniarray=$global:arrayg

new-item -Path "C:\tmp\test\myresult.txt" -Force|out-null
$checkloop=0
$i=0
$blocks=@()
$array1=$arrayx
foreach($inia in $iniarray){
    if($i -gt 0){
     $flag,$x,$y=($inia).split("|")
     $flag1,$x1,$y1=($inia0).split("|")
     $newblock="$x|$y"
     $array1[$x,$y]="#"
     $l=0
     $l=checkloop -flag $flag1 -x $x1 -y $y1
     if($l -eq 1 -and $newblock -notin $blocks){
      $m=0
      $m=checkloop -flag "^" -x $x0 -y $y0
      if($m -eq 1){
       $checkloop+=$n
       #add-content -path "C:\tmp\test\myresult.txt" -value "$x,$y"
       $blocks+=@($newblock)
       write-host "$x,$y, $checkloop cause loop" 
      }
     }
     else{
      add-content -path "C:\tmp\test\myresult_na.txt" -value "$x,$y"
     }
     $array1[$x,$y]="."
     $inia0=$inia
    }
   $i++
}
$checkloop


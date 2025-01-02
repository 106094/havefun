
 Add-Type -AssemblyName System.Windows.Forms
 start-process msedge https://adventofcode.com/2024/day/6/input
 start-sleep -s 5
 [System.Windows.Forms.SendKeys]::SendWait("^a")
 [System.Windows.Forms.SendKeys]::SendWait("^c")
 $lists=Get-Clipboard
 $linecount=$lists.count
 $dim=$lists[0].length 

 
function checkloop([string]$flag,[int]$x,[int]$y){
    $n=0
    $Global:arrayg=@()
while($x -ge 0 -and $x -lt $linecount -and $y -ge 0 -and $y -lt $dim){
   $paths="$flag|$($x)|$($y)"
    #$paths
  if( $paths -in $Global:arrayg ){
    $x=$linecount
    $n=1
  }
else{
    if($Global:arrayg){
    $x0=($Global:arrayg[-1].split("|"))[1]
    $y0=($Global:arrayg[-1].split("|"))[2]
    if($x -eq $x0 -and $y -eq $y0){
        $Global:arrayg[-1]=$paths
    }
    else{
        $Global:arrayg+=@($paths)
    }
   }
   else{
    $Global:arrayg+=@($paths)
   }
        

if($x -ge 0 -and $x -lt $linecount -and $y -ge 0 -and $y -lt $dim){
 if($flag -eq "v"){
    if($array[$($x+1),$y] -eq "#"){     
        $flag="<"
    }else{
        $x++
    }
  }
  elseif($flag -eq "<"){
    if($array[$x,$($y-1)] -eq "#"){        
        $flag="^"
    }else{
        $y--      
    }
  }
  elseif($flag -eq "^"){
    if($array[$($x-1),$y] -eq "#"){        
        $flag=">"
    }else{
        $x--
    }
  }
  elseif($flag -eq ">"){
    if($array[$x,$($y+1)] -eq "#"){       
      $flag= "v"
    }else{        
       $y++ 

    }
   }
  }
}
}
$n
}

 
$flag="^"
$array = New-Object 'object[,]' $linecount,$dim

for($i=0; $i -lt $linecount; $i++){
   for($j=0; $j -lt $dim; $j++){
       $array[$i,$j]=($lists[$i]).Substring($j,1)
         if(($array[$i,$j]) -eq $flag){
           $x0=$i
           $y0=$j
           $array[$i,$j]="."
       }
   }
  
}

checkloop -flag "^" -x $x0 -y $y0      
$iniarray=$Global:arrayg

new-item -Path "C:\tmp\test\myresult.txt" -Force|out-null
$checkloop=0
$i=0
$blocks=@()
foreach($inia in $iniarray){
    if($i -gt 0){
     $flag,$x,$y=($inia).split("|")
     $flag1,$x1,$y1=($inia0).split("|")
     $array[$x,$y]="#"
     $n=0
     $n=checkloop -flag $flag1 -x $x1 -y $y1
     if($n -eq 1 -and $inia -notin $blocks){
        $checkloop+=$n
       add-content -path "C:\tmp\test\myresult.txt" -value "$x,$y"
       $blocks+=@($inia)
       write-host "$x,$y, $checkloop"       
     }
     $array[$x,$y]="."
    }
    $inia0=$inia
    $i++
}
$checkloop


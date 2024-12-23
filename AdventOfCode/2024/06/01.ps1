
 Add-Type -AssemblyName System.Windows.Forms
 start-process msedge https://adventofcode.com/2024/day/6/input
 start-sleep -s 5
 [System.Windows.Forms.SendKeys]::SendWait("^a")
 [System.Windows.Forms.SendKeys]::SendWait("^c")
 $lists=Get-Clipboard
 $linecount=$lists.count
 $dim=$lists[0].length 
 
 $flag="^"
 $array = New-Object 'object[,]' $linecount,$dim

 for($i=0; $i -lt $linecount; $i++){
    for($j=0; $j -lt $dim; $j++){
        $array[$i,$j]=($lists[$i]).Substring($j,1)
          if(($array[$i,$j]) -eq $flag){
            $x=$i
            $y=$j
        }
    }
 }

 $arrayg=@()
 while($x -lt $linecount -and $y -lt $dim){
    $paths="$($x)|$($y)"
if($paths -notin  $arrayg){
    $arrayg+=@($paths)
}
 if($flag -eq "v"){
    if($array[($x+1),$y] -eq "#"){     
        $flag="<"
    }else{
        $x++
    }
  }
  elseif($flag -eq "<"){
    if($array[$x,($y-1)] -eq "#"){        
        $flag="^"
    }else{
        $y--      
    }
  }
  elseif($flag -eq "^"){
    if($array[($x-1),$y] -eq "#"){        
        $flag=">"
    }else{
        $x--
    }
  }
  elseif($flag -eq ">"){
    if($array[$x,($y+1)] -eq "#"){       
      $flag= "v"
    }else{        
       $y++ 

    }
  }

 }

 $arrayg.Count

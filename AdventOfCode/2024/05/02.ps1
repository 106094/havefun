
 Add-Type -AssemblyName System.Windows.Forms
 start-process msedge https://adventofcode.com/2024/day/5/input
 start-sleep -s 5
 [System.Windows.Forms.SendKeys]::SendWait("^a")
 [System.Windows.Forms.SendKeys]::SendWait("^c")
 $lists=Get-Clipboard
 
 $i=0
 $checklines=@()
 $rules=@()
 foreach($line in $lists){
     if($line -like "*|*"){
         $rules+=@([PSCustomObject]@{
             left = $line.split("|")[0]
             right = $line.split("|")[1]
         })
         $i++
     }
     if($line -like "*,*"){
         $checklines+=@($line)
         
     }
 }
 
$xcr=0
 foreach ($linec in  $checklines){
     $splitline=@($linec.split(","))
     $linerules=$rules|Where-Object{$_.left -in $splitline -and $_.right -in $splitline}

 $newruleset=@()
 $leftonly=$rightonly=""

 do{    
 $mid=( $linerules |Where-Object{$_.left -ne $leftonly}).left
 $linerules= $linerules |Where-Object{$_.left -ne $leftonly -and $_.right -ne $rightonly}
 if( $linerules){
 $lefts= $linerules.left
 $rights= $linerules.right
 $cpres=Compare-Object ($lefts|sort-object|Get-Unique) ($rights|sort-object|Get-Unique)
 $leftonly=($cpres|Where-Object {$_.SideIndicator -eq "<="}).InputObject
 $rightonly=($cpres|Where-Object {$_.SideIndicator -eq "=>"}).InputObject
 if($leftonly -and $rightonly){
    $newruleset+=@([PSCustomObject]@{
        left = $leftonly
        right = $rightonly
    })
  }
 }
 
 }while( $linerules)
  
 $ranks=@()
 $ranks+=@($newruleset.left)
 if($mid){
 $ranks+=@($mid)
 }
  $rankr=$newruleset.right
 $ranks+=@( $rankr|Sort-Object {$rankr.indexof($_)} -Descending)
 
 $rankline=$splitline|Sort-Object {$ranks.indexof($_)}
 
 if(($rankline  -join '') -ne ($splitline  -join '')){
 $xcr+=$rankline[($rankline.count-1)/2]

 }


 }

 $xcr

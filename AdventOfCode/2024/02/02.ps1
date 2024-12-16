function CheckRule {
  param (
      [int]$le,  
      [int]$ge, 
      [int[]]$numberSet,  
      [switch]$reverse
  )

  $linetexst=$numberSet -join " "
  $splitCount = $numberSet.Count

  for ($i = 0; $i -lt $splitCount - 1; $i++) {    
    $difference = $numberSet[$i + 1] - $numberSet[$i]
    if($reverse){
      $difference = $numberSet[$i] - $numberSet[$i + 1]
    }
      if ($difference -lt $ge -or $difference -gt $le) {
          $global:failedarray+=@($linetexst)
          return 0  # Rule violation, return 0
      }
  }
  $global:passedarray+=@($linetexst)
  return 1  # If all differences are valid, return 1
}


function CheckRule2 {
  param (
      [int]$le,  
      [int]$ge, 
      [int[]]$numberSet,  
      [switch]$reverse
  )
   $linetexst=$numberSet -join " "
   $splitCount = $numberSet.Count
  
for($i = 0; $i -le $splitCount - 1; $i++){    
  $n=0
  $numberSet2=@()
   $numberSet|ForEach-Object{  
    if($n -ne $i){
      #$n
      $numberSet2+=@($_)
    }
    $n++
  }
  
  $checkrule2=(checkrule -ge $ge -le $le -numberSet $numberSet2)[-1]
  if($reverse){
    $checkrule2=(checkrule -ge $ge -le $le -numberSet $numberSet2 -reverse)[-1]
   }
   $checkrule2
   if($checkrule2){
    $global:passedarray2+=@(($numberSet2 -join " ")+" delete $($numberSet[$i]) in $i of $linetexst")
    return 1
  }
  }    
    
    $global:failedarray2+=@($linetexst)
     return 0 
    

 }

 Add-Type -AssemblyName System.Windows.Forms
 start-process msedge https://adventofcode.com/2024/day/2/input
 start-sleep -s 5
 [System.Windows.Forms.SendKeys]::SendWait("^a")
 [System.Windows.Forms.SendKeys]::SendWait("^c")
 $lists=Get-Clipboard


$passcount=0
$global:passedarray=$global:failedarray=@()
foreach($list in $lists){
  $listarray = $list.Split(" ")
  $passcount+=CheckRule -ge 1 -le 3 -numberSet $listarray
}
$restcheck=$global:failedarray
$global:failedarray=@()
foreach($list in $restcheck){
  $listarray = $list.Split(" ")
  $passcount+=CheckRule -ge 1 -le 3 -numberSet $listarray -reverse
}
$passcount

$passcount2=$passcount
$restcheck2=$global:failedarray
$global:passedarray2=$global:failedarray2=@()
foreach($list in $restcheck2){
  $listarray = $list.Split(" ")  
  $passcount2+=(CheckRule2 -ge 1 -le 3 -numberSet $listarray)[-1]  
}
$passcount2

$restcheck2=$global:failedarray2
$global:failedarray2=@()
foreach($list in $restcheck2){
  $listarray = $list.Split(" ")  
  $passcount2+=(CheckRule2 -ge 1 -le 3 -numberSet $listarray -reverse)[-1]
}


$passcount2

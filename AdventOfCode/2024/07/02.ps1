
 Add-Type -AssemblyName System.Windows.Forms
 start-process msedge https://adventofcode.com/2024/day/7/input
 start-sleep -s 5
 [System.Windows.Forms.SendKeys]::SendWait("^a")
 [System.Windows.Forms.SendKeys]::SendWait("^c")
 $lists=Get-Clipboard

 function cal([int64]$num1,[int64]$num2,[string]$opr){
   if($opr -eq "0"){ 
    $cals=$num1+$num2
   }
   else{
    $cals=$num1*$num2
   } 
    $cals
 }
function bis($decimalNumber){
  $binaryString=$binaryString2=@()
  $maxlen=0
for($i=0; $i -lt $decimalNumber; $i++){
  $tobi=[Convert]::ToString($i, 2)
  $binaryString+= @($tobi)
  if($tobi.length -gt $maxlen){
    $maxlen=$tobi.length
  }
}
$binaryString|ForEach-Object{
  $bi=$_
  $len=$_.length
  if($len -lt $maxlen){
       $bi= (@("0") * ($maxlen-$len) -join "" )+"$_"
  }
  $binaryString2+=@("$bi")
}
$binaryString2
}


$pass=@()
$sumgood=$good=$cc=0
foreach($list in $lists){
  $cc++
    $nums=(($list.split(":"))[1]).trim()
    $sumnum=($list.split(":"))[0]
    $numsall=$nums.split(" ")|Where-Object {$_ -match "\d{1,}"}
    $numcount=$numsall.count
    $comcount = [math]::Pow(2, $numcount-1)
    $comall= bis -decimalNumber $comcount
    $checkdone=$false
    
    while (!$checkdone){
    foreach($opr in $comall){
       $inputdata=$nums
       $replacements=@()
        for($i=0 ; $i -lt $opr.length; $i++){
          $replacements+= @($opr.Substring($i,1))
         }
          $pattern = "\s"
          $matches = [regex]::Matches($inputdata, $pattern)
          $linkmark=@()
          $chars = $inputdata.ToCharArray()
          for ($i = 0; $i -lt $matches.Count; $i++) {
              if ($i -lt $replacements.Count) {
                  $matchIndex = $matches[$i].Index # Get the position of the match
                  if($replacements[$i] -eq "1"){
                      $chars[$matchIndex] = "|" # Replace the matched character
                      $linkmark+=@($i)
                  }
              }
          }
          # Output the result
          $output = (-join $chars)
          $comcount2 = [math]::Pow(2, $numcount-$linkmark.count-1)
          $comall2= bis -decimalNumber  $comcount2
              foreach($opr2 in $comall2){
                $result=$numsall[0]
                $x=0
                for ($i = 0; $i -lt $numcount-1; $i++) {
                  if($i -in $linkmark){
                    $result=[int64]$("$result"+"$($numsall[$i+1])")
                  }
                  if(!($i -in $linkmark)){
                    $operator=$opr2.Substring($x,1)
                    $result=cal -num1 $result -num2 $numsall[$i+1] -opr $operator  
                    $x++
                  }
                  if($result -gt $sumnum){
                    continue
                  }
                }
                if($result -eq $sumnum){
                  Write-Output  " ($cc/$($lists.count)) $list to $output by $opr with operator $($opr2) got $result"
                  $pass+=@("$list with $opr2 got $result")
                  $good+=1
                  $sumgood+=$sumnum
                  $checkdone=1
                  break
                }

              }
              if($opr -eq $comall[-1] -or $pass -like "*$list*"){
                $checkdone=1
                break
              }
  }

  
}
}
$sumgood


 

$targetsize = "Standard_B2pts_v2"
$dataFolder = "data"


$jsonFiles = Get-ChildItem -Path $dataFolder -Filter *.json

$MatchesRegions = @()

foreach($file in $jsonFiles){
  $filePath = $file.FullName

  $vmParameters = Get-content $filePath | ConvertFrom-Json

  $found = $vmParameters | Where-Object {$_.name -eq $targetsize}

  if ($found) {
    $region = $file.BaseName
    $MatchesRegions += $region
  }
}


$MatchesRegions | ConvertTo-Json | Set-Content -Path "result.json"


Write-Host "Результат експортовано до result.json"
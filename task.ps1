# Write your code here
$avaliableRegion = @()


$regionsJson = Get-ChildItem -Path "./data"
foreach($data in $regionsJson) {
 $vmSize = Get-Content $data | ConvertFrom-Json
    if ($vmSize.Name -eq "Standard_B2pts_v2"){
      $region = $data.Name.Replace('.json', '')
      $avaliableRegion += $region
    }
}

$avaliableRegion | ConvertTo-Json | Set-Content -Path "./result.json"
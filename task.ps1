
$foundRegions = @()
$files = Get-ChildItem -Path "./data" -Filter "*.json"

foreach ($file in $files) {
  $vmSizes = Get-Content -Path $file.FullName | ConvertFrom-Json
  $targetVM = $vmSizes | Where-Object { $_.name -eq "Standard_B2pts_v2" }
  if ($targetVM) {
    $regionName = $file.Name.Replace('.json', '')
    $foundRegions += $regionName
  }
}

$foundRegions | ConvertTo-Json | Out-File -FilePath "./result.json"
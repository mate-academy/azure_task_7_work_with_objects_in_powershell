$files = Get-ChildItem -Path "./data" -Filter *.json
$matchingRegions = @()
foreach ($file in $files) {
  $regionName = $file.Name.Replace('.json', '')
  $jsonContent = Get-Content $file.FullName | ConvertFrom-Json
    foreach ($vmSize in $jsonContent) {
      if ($vmSize.name -eq "Standard_B2pts_v2") {
        $matchingRegions += $regionName
        Write-Host $regionName
        break
        }
    }
}
$matchingRegions | ConvertTo-Json | Set-Content "./result.json"

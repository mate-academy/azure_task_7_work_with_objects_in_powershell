$regionWithVM = @()
$files = Get-ChildItem -Path "./data" -Filter *.json

foreach ($file in $files) {
  $vmSizes = Get-Content $file.FullName | ConvertFrom-Json

  if($vmSizes |  Where-Object { $_.name -eq "Standard_B2pts_v2"}) {
    $region = $file.BaseName
    $regionWithVM += $region
  }
}

$regionWithVM | ConvertTo-Json | Set-Content -Path "./result.json"
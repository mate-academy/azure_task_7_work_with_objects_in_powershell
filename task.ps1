$region = @()
$files = Get-ChildItem -Path ./data -File
foreach ($file in $files) {
  $vm = Get-Content $file.FullName | ConvertFrom-Json

  if ($vm.Name -contains "Standard_B2pts_v2") {
    $regionName = $file.Name.Replace('.json', '')
    $region += $regionName
  }
}
$region | ConvertTo-Json | Out-File -FilePath "./result.json"
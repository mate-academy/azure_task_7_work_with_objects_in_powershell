# Write your code here
$jsonsFilePath = Get-ChildItem -Path ./data -Filter '*.json'
$result = @()

foreach ($file in $jsonsFilePath) {
  $regionName = $file.BaseName
  $json = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
  if ($json | Where-Object Name -eq "Standard_B2pts_v2") {
    $result += $regionName
  }
}

$result | ConvertTo-Json -AsArray | Out-File "result.json"
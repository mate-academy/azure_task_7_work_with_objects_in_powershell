$dataPath = "./data"

$result = @()

foreach ($file in Get-ChildItem -Path $dataPath) {
  $content = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

  $found = $content | Where-Object { $_.Name -eq "Standard_B2pts_v2" }

  if ($found) {
    $region = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    $result += $region
  }
}

$result | ConvertTo-Json | Set-Content -Path "./result.json" -Encoding UTF8
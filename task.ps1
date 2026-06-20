$targetSize = "Standard_B2pts_v2"
$regions = @()

$files = Get-ChildItem -Path "$PWD/data" -Filter "*.json"

foreach ($file in $files) {
    $vmSizes = Get-Content -Path $file.FullName | ConvertFrom-Json
    $match = $vmSizes | Where-Object { $_.Name -eq $targetSize }

    if ($match) {
        $region = $file.Name.Replace('.json', '')
        $regions += $region
    }
}

$regions | ConvertTo-Json | Out-File -FilePath "$PWD/result.json"

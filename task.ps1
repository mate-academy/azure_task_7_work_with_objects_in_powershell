$regions = @()

$files = Get-ChildItem -Path "$PSScriptRoot/data" -Filter "*.json"

foreach ($file in $files) {
    $vmSizes = Get-Content -Path $file.FullName | ConvertFrom-Json
    $found = $vmSizes | Where-Object { $_.Name -eq "Standard_B2pts_v2" }

    if ($found) {
        $regionName = $file.Name.Replace(".json", "")
        $regions += $regionName
    }
}

$regions | ConvertTo-Json | Out-File -FilePath "$PSScriptRoot/result.json" -Encoding utf8

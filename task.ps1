$availableRegions = @()

$files = Get-ChildItem -Path "./data" -Filter *.json

foreach ($file in $files) {
    $path = $file.FullName

    $vmSizes = Get-Content $path | ConvertFrom-Json

    if ($vmSizes | Where-Object { $_.name -eq "Standard_B2pts_v2" }) {
        $region = $file.Name.Replace(".json", "")
        $availableRegions += $region
    }
}

$availableRegions | ConvertTo-Json | Set-Content -Path "./result.json"
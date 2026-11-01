$targetVmSize = "Standard_B2pts_v2"
$availableRegions = @()

$files = Get-ChildItem -Path ".\data" -Filter "*.json"

foreach ($file in $files) {
    $vmData = Get-Content -Path $file.FullName | ConvertFrom-Json

    $found = $vmData | Where-Object { $_.name -eq $targetVmSize }

    if ($found) {
        $regionName = $file.Name.Replace('.json', '')
        $availableRegions += $regionName
    }
}

$availableRegions | ConvertTo-Json | Out-File -Path ".\result.json"
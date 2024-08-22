
$regionsWithVMSize = @()

$regions = Get-ChildItem -Path ".\data"
foreach ($region in $regions) {
    $jsonData = Get-Content -Path $region.FullName | ConvertFrom-Json
    $foundVMSize = $jsonData | Where-Object { $_.name -eq "Standard_B2pts_v2" }
    if ($foundVMSize) {
        $regionName = $region.Name.Replace('.json', '')
        $regionsWithVMSize += $regionName
    }
}

$regionsWithVMSize | ConvertTo-Json -Depth 10 | Set-Content -Path ".\result.json"

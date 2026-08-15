$results = @()
$regions = Get-ChildItem -Path "./data/"

foreach ($region in $regions) {
    $vmSizes = Get-Content -Path $region.FullName -Raw | ConvertFrom-Json
    $found = $vmSizes | Where-Object { $_.Name -eq "Standard_B2pts_v2" }
    
    if ($found) {
        $regionName = $region.Name.Replace('.json', '')
        $results += $regionName
    }
}
$results | ConvertTo-Json | Out-File -Path "./result.json"

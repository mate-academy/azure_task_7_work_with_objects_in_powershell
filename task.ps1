# Write your code here
$files = Get-ChildItem .\data -Filter *.json
$availableRegions = @()
foreach ($file in $files) {
    $vmSizes = Get-Content $file.FullName | ConvertFrom-Json
    $targetVm = $vmSizes | Where-Object { $_.Name -eq "Standard_B2pts_v2" }
    if ($targetVm) {
        $regionName = $file.Name.Replace('.json', '')
        $availableRegions += $regionName

    }
}
$availableRegions | ConvertTo-Json | Out-File result.json
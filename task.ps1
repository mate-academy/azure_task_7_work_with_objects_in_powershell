Write-Host "Start searching regions which has Standard_B2pts_v2 vm size"

Write-Host "Scanning files in ./data directory..."
$RegionFiles = Get-ChildItem -Path ./data

$ValidRegions = @()
foreach ($RegionFile in $RegionFiles)
{
    Write-Host "Processing file: $($RegionFile.Name)"
    $RegionSizes = Get-Content -Path $RegionFile | ConvertFrom-Json

    foreach ($Size in $RegionSizes)
    {
        if ($Size.Name -eq "Standard_B2pts_v2")
        {
            Write-Host "Found Standard_B2pts_v2 in region: $($RegionFile.Name.Replace('.json', ''))"
            $ValidRegions += $RegionFile.Name.Replace(".json", "")
            break
        }
    }
}

Write-Host "Writing valid regions to test.txt"
ConvertTo-Json -InputObject $ValidRegions | Out-File -Path result.json

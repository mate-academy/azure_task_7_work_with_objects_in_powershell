$targetVmSize = "Standard_B2pts_v2"
$dataFolder = Join-Path $PSScriptRoot "data"
$resultFile = Join-Path $PSScriptRoot "result.json"

$matchingRegions = @()

$files = Get-ChildItem -Path $dataFolder -Filter "*.json"

foreach ($file in $files) {
    $regionName = $file.Name.Replace('.json', '')

    $jsonContent = Get-Content -Path $file.FullName -Raw
    $vmSizes = $jsonContent | ConvertFrom-Json

    $found = $vmSizes | Where-Object { $_.Name -eq $targetVmSize }

    if ($found) {
        $matchingRegions += $regionName
    }
}

$matchingRegions | ConvertTo-Json | Set-Content -Path $resultFile

Write-Host "Found $($matchingRegions.Count) region(s) with $targetVmSize available:"
$matchingRegions | ForEach-Object { Write-Host " - $_" }
$targetVmSize = "Standard_B2pts_v2"
$dataFolder = Join-Path $PSScriptRoot "data"
$resultFile = Join-Path $PSScriptRoot "result.json"
$regions = @()

$files = Get-ChildItem -Path $dataFolder -File -Filter "*.json"

foreach ($file in $files) {
    $vmSizes = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
    $match = $vmSizes | Where-Object { $_.Name -eq $targetVmSize }
    if ($match) {
        $regions += $file.Name.Replace(".json", "")
    }
}

$regions | ConvertTo-Json | Out-File -FilePath $resultFile -Force
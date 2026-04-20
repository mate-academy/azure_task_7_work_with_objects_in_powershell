$vmSizeName = "Standard_B2pts_v2"

$dataDir = Join-Path -Path $PSScriptRoot -ChildPath "data"
$resultPath = Join-Path -Path $PSScriptRoot -ChildPath "result.json"

$regions = New-Object System.Collections.Generic.List[string]

Get-ChildItem -Path $dataDir -Filter "*.json" -File | ForEach-Object {
    $regionName = $_.BaseName
    $vmSizes = Get-Content -Path $_.FullName -Raw | ConvertFrom-Json

    if ($null -ne ($vmSizes | Where-Object { $_.Name -eq $vmSizeName } | Select-Object -First 1)) {
        $regions.Add($regionName)
    }
}

$regions
| Sort-Object
| ConvertTo-Json
| Set-Content -Path $resultPath -Encoding UTF8

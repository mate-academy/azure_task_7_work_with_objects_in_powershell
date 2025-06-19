$dataPath = "./data"
$resultPath = "./result.json"

$availableRegions = @()

Get-ChildItem -Path $dataPath -Filter *.json | ForEach-Object {
    $regionFile = $_.FullName
    $regionName = $_.BaseName

    $vmSizes = Get-Content -Path $regionFile | ConvertFrom-Json

    if ($vmSizes -contains "Standard_B2pts_v2") {
        $availableRegions += $regionName
    }
}

$availableRegions | ConvertTo-Json -Depth 1 | Set-Content -Path $resultPath -Encoding UTF8

$vmSizeName = "Standard_B2pts_v2"
$dataFolder = "data"
$regionsWithVm = @()

Get-ChildItem -Path $dataFolder -Filter *.json | ForEach-Object {
    $filePath = $_.FullName
    $regionName = $_.Name.Replace(".json", "")

    $vmSizes = Get-Content $filePath -Raw | ConvertFrom-Json
    $found = $vmSizes | Where-Object { $_.Name -eq $vmSizeName }

    if ($found) {
        $regionsWithVm += $regionName
    }
}

$regionsWithVm | ConvertTo-Json | Set-Content "result.json"

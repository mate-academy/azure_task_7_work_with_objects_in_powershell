$regions = @()

Get-ChildItem -Path "data" -Filter *.json | ForEach-Object {
    $regionName = $_.BaseName
    $vmSizes = Get-Content $_.FullName | ConvertFrom-Json
    if ($vmSizes.name -contains "Standard_B2pts_v2") {
        $regions += $regionName
    }
}

$regions | ConvertTo-Json | Out-File "result.json" -Encoding utf8

# task.ps1

$regions = @()

Get-ChildItem -Path "data" -Filter *.json | ForEach-Object {
    $regionName = $_.BaseName
    $vmSizes = Get-Content -Raw -Path $_.FullName | ConvertFrom-Json

    if ($vmSizes.name -eq "Standard_B2pts_v2") {
        $regions += $regionName
    }
}

$regions | Sort-Object -Unique | ConvertTo-Json | Out-File "result.json" -Encoding utf8

#! /usr/lib64/powershell/pwsh

$items = Get-ChildItem data
$fullJson = @()

foreach ($item in $items) {
    $region = $item -replace "$PWD/data/" -replace ".json"
    $context =  Get-Content -Path $item | ConvertFrom-Json
    foreach ($object in $context) {
        if ($object.Name -eq "Standard_B2pts_v2") {
            $fullJson += $region
            break
        }
    }
}
$fullJson | ConvertTo-Json | Out-File result.json
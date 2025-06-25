# Write your code here
$dataFolder = "data"

$matchingRegions = @()

$jsonFiles = Get-ChildItem -Path $dataFolder -Filter *.json

foreach ($file in $jsonFiles) {
    $filePath = $file.FullName

    $vmSizes = Get-Content $filePath | ConvertFrom-Json

    $found = $vmSizes | Where-Object { $_.name -eq "Standard_B2pts_v2" }

    if ($found) {
        $region = $file.BaseName
        $matchingRegions += $region
    }
}

# Експортуємо результат у файл result.json у форматі JSON
$matchingRegions | ConvertTo-Json | Set-Content -Path "result.json"

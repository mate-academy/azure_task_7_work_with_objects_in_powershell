$dataPath = ".\data"
$vmSizeToFind = "Standard_B2pts_v2"
$resultRegions = @()

$jsonFiles = Get-ChildItem -Path $dataPath -Filter *.json

foreach ($file in $jsonFiles) {
    $content = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
    
    # Перевірка наявності потрібного VM розміру у файлі
    if ($content | Where-Object { $_.name -eq $vmSizeToFind }) {
        $region = $file.BaseName
        $resultRegions += $region
    }
}

$resultFilePath = ".\result.json"
$resultRegions | ConvertTo-Json -Depth 1 | Out-File -FilePath $resultFilePath -Encoding utf8

Write-Host "Результати збережено у $resultFilePath"

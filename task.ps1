# Write your code here
$targetVmSize = "Standard_B2pts_v2"
$dataPath = Join-Path -Path $PSScriptRoot -ChildPath "data"
$outputPath = Join-Path -Path $PSScriptRoot -ChildPath "result.json"

$matchingRegions = @()

# Отримуємо перелік JSON-файлів із папки data
$jsonFiles = Get-ChildItem -Path $dataPath -Filter "*.json"

foreach ($file in $jsonFiles) {
    # Зчитуємо вміст та десеріалізуємо з JSON в об'єкти
    $vmList = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    # Перевіряємо наявність необхідного розміру ВМ
    $isAvailable = $vmList | Where-Object {
        $_.name -eq $targetVmSize -or
        $_.size -eq $targetVmSize -or
        $_ -eq $targetVmSize
    }

    if ($isAvailable) {
        # Отримуємо назву регіону, відрізавши розширення .json
        $regionName = $file.Name.Replace('.json', '')
        $matchingRegions += $regionName
    }
}

# Експортуємо підсумковий масив регіонів у файл result.json
$matchingRegions | ConvertTo-Json | Set-Content -Path $outputPath -Encoding utf8

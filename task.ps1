# Шлях до папки з даними
$dataFolder = "./data"
$targetVmSize = "Standard_B2pts_v2"
$resultRegions = @()

# Отримуємо всі json файли з папки
$files = Get-ChildItem -Path $dataFolder -Filter "*.json"

foreach ($file in $files) {
    # Зчитуємо вміст файлу та конвертуємо JSON в об'єкти PowerShell
    $jsonContent = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    # Шукаємо об'єкт, де розмір VM відповідає заданому
    $found = $jsonContent | Where-Object { $_.name -eq $targetVmSize -or $_.size -eq $targetVmSize }

    if ($found) {
        # Назва регіону береться з імені файлу (без розширення) або зсередини об'єкта
        $regionName = $file.BaseName
        $resultRegions += $regionName
    }
}

# Експорт результату у файл result.json
$resultRegions | ConvertTo-Json -Depth 10 | Set-Content -Path "result.json"
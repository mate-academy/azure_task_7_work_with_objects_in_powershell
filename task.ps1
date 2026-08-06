# Встановлюємо розташування скрипту як робочу папку
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Список для збереження регіонів
$regionsWithVM = @()

# Отримуємо всі JSON файли з папки 'data'
$jsonFiles = Get-ChildItem -Path "./data" -Filter "*.json"

# Проходимо через кожен файл
foreach ($file in $jsonFiles) {
    # Отримуємо ім'я регіону (видаляємо '.json')
    $regionName = $file.BaseName
    
    # Читаємо JSON з файлу (FIX: FullName замість FullPath)
    $content = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
    
    # Шукаємо VM розмір 'Standard_B2pts_v2'
    $vmSize = $content | Where-Object { $_.name -eq "Standard_B2pts_v2" }
    
    # Якщо знайшли - додаємо регіон до списку
    if ($vmSize) {
        $regionsWithVM += $regionName
        Write-Host "Знайдено $regionName"
    }
}

# Сортуємо регіони
$regionsWithVM = $regionsWithVM | Sort-Object

# Експортуємо результат в JSON файл
$regionsWithVM | ConvertTo-Json | Out-File -Path "./result.json" -Encoding UTF8

Write-Host "Готово! Результати збережені в result.json"
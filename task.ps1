# Write your code here
# task.ps1
# Ціль: знайти всі регіони, де доступний VM size Standard_B2pts_v2,
#       читаючи локальні JSON-файли з папки ./data

param(
    [string]$DataDir = "./data",
    [string]$TargetSize = "Standard_B2pts_v2",
    [string]$OutFile = "./result.json"
)

# Перевірки
if (-not (Test-Path -LiteralPath $DataDir)) {
    throw "Data directory '$DataDir' not found. Очікую папку з JSON-файлами регіонів."
}

$regionsWithSize = New-Object System.Collections.Generic.List[string]

# Беремо лише .json файли
Get-ChildItem -LiteralPath $DataDir -File -Filter *.json | ForEach-Object {
    $file = $_
    try {
        # Зміст файлу як один рядок -> в об’єкти
        $json = Get-Content -LiteralPath $file.FullName -Raw | ConvertFrom-Json

        # Очікувана структура: масив об’єктів із властивістю name (або properties.name).
        # Найчастіше у таких файлах або json[].name, або json[].name/value.
        # Підстрахуємось: шукаємо 'Standard_B2pts_v2' у кількох полях.
        $hasTarget = $false

        foreach ($item in $json) {
            # Нормалізуємо до рядка
            $n1 = ($item.name | Out-String).Trim()
            $n2 = ($item.vmSize | Out-String).Trim()
            $n3 = ($item.properties.name | Out-String).Trim()

            if ($n1 -eq $TargetSize -or $n2 -eq $TargetSize -or $n3 -eq $TargetSize) {
                $hasTarget = $true
                break
            }
        }

        if ($hasTarget) {
            # Ім’я регіону беремо з назви файлу (без .json), приводимо до lower
            $region = ($file.Name).Replace(".json","").ToLowerInvariant()
            $regionsWithSize.Add($region)
        }
    }
    catch {
        Write-Warning "Не вдалося обробити '$($file.Name)': $($_.Exception.Message)"
    }
}

# Сортуємо та унікалізуємо на всякий випадок
$uniqueSorted = $regionsWithSize | Sort-Object -Unique

# Експорт у JSON-масив
$uniqueSorted | ConvertTo-Json -Depth 3 | Set-Content -LiteralPath $OutFile -Encoding UTF8

Write-Host "Готово. Знайдено регіонів: $($uniqueSorted.Count)"
Write-Host "Результат збережено у $OutFile"

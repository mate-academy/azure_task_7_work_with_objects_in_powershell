# Write your code here
# task.ps1
$ErrorActionPreference = "Stop"

$targetVmSize = "Standard_B2pts_v2"

# Путь к папке data относительно расположения скрипта
$repoRoot = $PSScriptRoot
if (-not $repoRoot) { $repoRoot = (Get-Location).Path }  # на случай ручного запуска
$dataDir = Join-Path $repoRoot "data"

if (-not (Test-Path $dataDir)) {
    throw "Folder 'data' not found at path: $dataDir"
}

# Функция: проверяет объект (любой формы) на наличие VM size
function Contains-VmSize {
    param(
        [Parameter(Mandatory=$true)] $Item,
        [Parameter(Mandatory=$true)] [string] $Target
    )

    if ($null -eq $Item) { return $false }

    # Если это строка
    if ($Item -is [string]) {
        return ($Item -eq $Target)
    }

    # Если это объект с понятными полями
    foreach ($propName in @("name","Name","vmSize","VmSize","size","Size","sku","Sku")) {
        if ($Item.PSObject.Properties.Name -contains $propName) {
            $val = $Item.$propName
            if ($val -is [string] -and $val -eq $Target) { return $true }
        }
    }

    # Если структура неизвестна — проверим все строковые свойства
    foreach ($p in $Item.PSObject.Properties) {
        try {
            if ($p.Value -is [string] -and $p.Value -eq $Target) { return $true }
        } catch {}
    }

    return $false
}

$regions = @()

Get-ChildItem -Path $dataDir -Filter "*.json" -File | ForEach-Object {
    $file = $_
    $region = $file.BaseName  # имя файла без .json

    $raw = Get-Content -Path $file.FullName -Raw
    $objects = $raw | ConvertFrom-Json

    # ConvertFrom-Json может вернуть один объект, приводим к массиву
    if ($objects -isnot [System.Collections.IEnumerable] -or $objects -is [string]) {
        $objects = @($objects)
    }

    $found = $false
    foreach ($obj in $objects) {
        if (Contains-VmSize -Item $obj -Target $targetVmSize) {
            $found = $true
            break
        }
    }

    if ($found) {
        $regions += $region
    }
}

# На всякий случай: сортировка + уникальные
$regions = $regions | Sort-Object -Unique

# Записываем JSON-массив строк в result.json в корне репо
$resultPath = Join-Path $repoRoot "result.json"
$regions | ConvertTo-Json | Set-Content -Path $resultPath -Encoding utf8

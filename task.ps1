# Write your code here
Write-Host "Запуск скрипту..."
$regionsWithStandardB2ptsV2 = @()

Get-ChildItem -Path .\data | ForEach-Object {
  Write-Host "Обробка файлу: $($_.Name)"
  $file_path = $_.FullName
  $region = $_.Name.Replace('.json', '')
  $vmsizes = Get-Content -Path $file_path | ConvertFrom-Json

  if ($vmsizes -contains "Standard_B2pts_v2") {
    Write-Host "Знайдено Standard_B2pts_v2 у регіоні: $region"
    $regionsWithStandardB2ptsV2 += $region
  }
}

Write-Host "Завершення скрипту, експорт результатів..."

if ($regionsWithStandardB2ptsV2.Count -eq 0) {
    Write-Host "Немає регіонів, де доступний Standard_B2pts_v2."
} else {
    $regionsWithStandardB2ptsV2 | ConvertTo-Json | Set-Content -Path .\result.json
    Write-Host "Файл result.json створено успішно!"
}

if (Test-Path -Path .\result.json) {
    Write-Host "Файл result.json створено!"
} else {
    Write-Host "Помилка: файл result.json не створений."
}

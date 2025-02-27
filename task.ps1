$dataPath = "./data"
$resultFile = "result.json"

# Отримуємо список JSON-файлів у папці
$jsonFiles = Get-ChildItem -Path $dataPath -Filter "*.json"

# Масив для збереження результатів
$regionsWithVMs = @()

foreach ($file in $jsonFiles) {
  # Зчитуємо вміст файлу
  $jsonContent = Get-Content -Raw -Path $file.FullName | ConvertFrom-Json
    
  # Переконуємось, що JSON — це масив
  if ($jsonContent -is [array]) {
    # Фільтруємо машини, що відповідають потрібному розміру
    $matchingVMs = $jsonContent | Where-Object { $_.Name -eq "Standard_B2pts_v2" }
        
    if ($matchingVMs) {
      # Зберігаємо регіон, де знайдено підходящі ВМ
      $regionsWithVMs += $file.BaseName
    }
  }
}

# Перевіряємо, чи були знайдені відповідні ВМ
if ($regionsWithVMs.Count -gt 0) {
  # Записуємо результати у JSON-файл
  $regionsWithVMs | ConvertTo-Json -Depth 1 | Set-Content -Path $resultFile
  Write-Output "Фільтровані дані збережено в $resultFile"
}
else {
  Write-Output "Не знайдено відповідних машин"
}

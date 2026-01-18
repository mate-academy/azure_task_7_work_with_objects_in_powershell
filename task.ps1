$files = Get-ChildItem -Path ".\data" -Filter "*.json"
$targetSizeName = "Standard_B2pts_v2"
$results = @()

foreach ($file in $files) {
    $objectFile = Get-Content $file.FullName | ConvertFrom-Json

    if ($objectFile | Where-Object { $_.Name -eq $targetSizeName }) {
        $results += $file.BaseName
    }
}

$results | ConvertTo-Json | Out-File -FilePath ".\result.json" -Encoding utf8
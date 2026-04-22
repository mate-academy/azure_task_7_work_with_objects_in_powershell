$results = New-Object System.Collections.Generic.List[PSObject]

$files = Get-ChildItem -Path ".\data" -File

foreach ($file in $files) {
    $data_massive = Get-Content -Raw -Path $file.FullName | ConvertFrom-Json

    foreach ($data in $data_massive) {
        if ($data.Name -eq "Standard_B2pts_v2") {
            $results.Add($file.BaseName)
        }
    }
}

$results | ConvertTo-Json -Depth 5 | Out-File -FilePath ".\result.json" -Encoding UTF8
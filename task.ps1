$regions_with_correct_size = @()

$files = Get-ChildItem -Path "data" -Filter "*.json"

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName | ConvertFrom-Json
    if ($content | Where-Object { $_.Name -eq "Standard_B2pts_v2" })
    {
        $regions_with_correct_size += $file.BaseName
    }
}

ConvertTo-Json -InputObject $regions_with_correct_size | Out-File -FilePath "result.json"
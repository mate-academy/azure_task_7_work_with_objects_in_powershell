$files = Get-ChildItem -Path "./data" -Filter *.json
$regions = @()

foreach ($file in $files) {
    Write-Host "Processing file: $($file.Name)"
    $content = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
    $found = $false
    foreach ($item in $content) {
        if ($item.Name -eq "Standard_B2pts_v2") {
            Write-Host "Found Standard_B2pts_v2 in region: $($file.Name.Replace('.json', ''))"
            $regionName = $file.Name.Replace('.json', '')
            $regions += $regionName
            $found = $true
            break
        }
    }
}

$regions | ConvertTo-Json | Set-Content -Path "./result.json"

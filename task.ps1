# Write your code here

$files = Get-ChildItem -Path "./data" -Filter *.json


$regions = @()

foreach ($file in $files) {
    try {
        $content = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
    }
    catch {
        Write-Warning "Failed to parse $($file.Name)"
        continue
    }

    $found = $content | Where-Object { $_.Name -eq "Standard_B2pts_v2" }

    if ($found) {
        $region = $file.BaseName
        $regions += $region
    }
}

$regions | ConvertTo-Json | Out-File -Encoding utf8 "./result.json"


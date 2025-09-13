# Write your code here

$files = Get-ChildItem -Path "./data" -Filter *.json


$regions = @()

foreach ($file in $files) {

    $content = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json


    $found = $content | Where-Object { $_.Name -eq "Standard_B2pts_v2" }

    if ($found) {

        $region = $file.BaseName
        $regions += $region
    }
}

$regions | ConvertTo-Json | Out-File -Encoding utf8 "./result.json"


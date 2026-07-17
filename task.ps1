# Write your code here

$files = Get-ChildItem -Path .\data
$result = @()

foreach ($file in $files) {
    $sizes = Get-Content -Raw -Path $file | ConvertFrom-Json
    $region = $file.BaseName
    foreach ($size in $sizes) {
        if ($size.Name -eq 'Standard_B2pts_v2') {
            $result += $region
            break
        }
    }
}

$result | ConvertTo-Json | Out-File -FilePath .\result.json
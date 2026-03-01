# Write your code here
$target = "Standard_B2pts_v2"
$found = @()

if (Test-Path "./data") {
    $files = Get-ChildItem -Path "./data" -Filter "*.json"
    foreach ($file in $files) {
        $data = Get-Content $file.FullName -Raw | ConvertFrom-Json
        if ($data -contains $target -or $data.name -contains $target) {
            $found += $file.BaseName
        }
    }
}

$found | ConvertTo-Json | Out-File -FilePath "result.json" -Encoding utf8


$files = Get-ChildItem -Path "./data" -Filter "*.json"
$regions = @()

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName | ConvertFrom-Json
    if ($content.name -contains "Standard_B2pts_v2") {
        $regionName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $regions += $regionName
    }
}

$regions | ConvertTo-Json | Set-Content -Path "./result.json"

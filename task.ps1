$results = @()
$files = Get-ChildItem -Path ./data -Filter *.json
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName | ConvertFrom-Json
    $found = $content | Where-Object { $_.Name -eq "Standard_B2pts_v2" }
    if ($found) {
        $regionName = $file.Name.Replace('.json', '')
        $results += $regionName
    }
}
$results | ConvertTo-Json | Set-Content -Path ./result.json

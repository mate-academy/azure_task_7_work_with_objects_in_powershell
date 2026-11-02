$vmSize = "Standard_B2pts_v2"
$result = @()
$files = Get-ChildItem -Path "./data"

foreach ($file in $files) {
    $region = $file.Name.Replace(".json", "")
    $content = Get-Content -Path $file.FullName
    $sizes = $content | ConvertFrom-Json
    $found = $false

    foreach ($size in $sizes) {
        if ($size.Name -eq $vmSize) {
            $found = $true
        }
    }

    if ($found -eq $true) {
        $result += $region
    }
}

$json = ConvertTo-Json -InputObject $result
$json | Out-File -FilePath "./result.json"
$vmSize = "Standard_B2pts_v2"
$result = @()

$files = Get-ChildItem -Path "$PSScriptRoot\data" -Filter "*.json"

foreach ($file in $files) {
    $data = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    $vm = $data | Where-Object { $_.Name -eq $vmSize }

    if ($vm) {
        $region = $file.BaseName
        $result += $region
    }
}

$result |
    Sort-Object |
    ConvertTo-Json |
    Set-Content -Path "$PSScriptRoot\result.json"
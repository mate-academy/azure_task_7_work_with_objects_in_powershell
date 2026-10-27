$files = Get-ChildItem -Path ./data
$regions = @()

foreach ($file in $files) {
    $vm = Get-Content -Path $file.FullName | ConvertFrom-Json | Where-Object { $_.Name -eq "Standard_B2pts_v2" }

    if ($vm) {
        $regions += $file.Name.Replace(".json", "")
    }
}

$regions | ConvertTo-Json | Set-Content -Path ./result.json
$files = Get-ChildItem data -Filter *.json
$result = @()

foreach ($file in $files) {
    $vms = Get-Content $file | ConvertFrom-Json

    $found = $vms | Where-Object { $_.Name -eq "Standard_B2pts_v2" }

    if ($found) {
        $result += $file.Name.Replace('.json', '')
    }
}

$result | ConvertTo-Json | Set-Content result.json
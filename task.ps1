$files = Get-ChildItem ./data

$arr = @()

foreach ($file in $files) {
    $decodedObject = Get-Content $file.FullName | ConvertFrom-Json
    foreach ($vmSize in $decodedObject) {
        if ($vmSize.Name -eq "Standard_B2pts_v2") {
            $regionName = $file.Name.Replace('.json', '')
            $arr += $regionName
        }
    }
}

$arr | ConvertTo-Json | Out-File -Path ./result.json

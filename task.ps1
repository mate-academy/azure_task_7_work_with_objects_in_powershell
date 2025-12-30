$regions = @()

foreach ($file in Get-ChildItem -Path ./data) {
    $fileData = $file | Get-Content | ConvertFrom-Json
    $availableSize = $fileData | Where-Object {$_.Name -eq "Standard_B2pts_v2"}

    if ($null -ne $availableSize) {
        $regions += $file.Name.Replace(".json", "")
    }
}

$regions | ConvertTo-Json | Out-File -FilePath ./result.json

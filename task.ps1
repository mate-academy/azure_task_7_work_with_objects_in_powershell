$files = Get-ChildItem -Path "$PSScriptRoot/data" -Filter "*.json"

$result = foreach ($file in $files) {
    $sizes = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
    if ($sizes | Where-Object { $_.Name -eq "Standard_B2pts_v2" }) {
        $file.Name.Replace('.json', '')
    }
}

$result | ConvertTo-Json -AsArray | Out-File -FilePath "$PSScriptRoot/result.json"
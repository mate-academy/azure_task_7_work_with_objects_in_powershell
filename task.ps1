$sizeName = 'Standard_B2pts_v2'
$regions = @()

foreach ($file in Get-ChildItem -Path "$PWD/data" -Filter '*.json') {
    $sizes = Get-Content $file.FullName -Raw | ConvertFrom-Json
    if ($sizes | Where-Object { $_.Name -eq $sizeName }) {
        $regions += $file.Name.Replace('.json', '')
    }
}

ConvertTo-Json -InputObject $regions | Out-File "$PWD/result.json"

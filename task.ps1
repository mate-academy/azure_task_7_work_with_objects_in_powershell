$lookingFor = "Standard_B2pts_v2"
$result = @()  

Get-ChildItem ./data -Filter *.json | ForEach-Object {
    $file = $_
    $json = Get-Content $file.FullName -Raw | ConvertFrom-Json

    foreach ($line in $json) {
        if ($line.name -eq $lookingFor) {
            $region = $file.Name -replace ".json", ""
            $result += $region
            Write-Host "✅ Знайдено в файлі: $region"
        }
    }
}


$result | ConvertTo-Json -Depth 1 | Set-Content -Encoding UTF8 "./result.json"
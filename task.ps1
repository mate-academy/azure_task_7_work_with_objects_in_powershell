$path = ".\data"

Get-ChildItem -Path $path -Filter *.json | ForEach-Object {
    $data = Get-Content $_.FullName | ConvertFrom-Json

    if ($data | Where-Object { $_.Name -eq "Standard_B2pts_v2" }) {
        $_.BaseName
    }
} | ConvertTo-Json | Out-File -FilePath ".\result.json"
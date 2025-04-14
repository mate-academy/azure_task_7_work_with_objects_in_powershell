$files = Get-ChildItem "./data/"
[array]$res = @()

foreach ($file in $files) {
    $content = Get-Content $file | ConvertFrom-Json
    foreach ($obj in $content) {
        if ($obj.Name -eq 'Standard_B2pts_v2') {
            $res = $res + $file.BaseName
        }
    }
}


ConvertTo-Json $res | Out-File -Path./result.json


$list_of_files = Get-ChildItem -Path "./data"
$list = @()
foreach ($file in $list_of_files) {
    $content = Get-Content $file | ConvertFrom-Json
    foreach ($object in $content) {
        if ($object.Name -eq "Standard_B2pts_v2") {
            $list += $file.BaseName
        }
    }
}

$list | ConvertTo-Json | Out-File -Path ./result.json

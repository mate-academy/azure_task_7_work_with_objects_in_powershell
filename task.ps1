$checkfile = Get-ChildItem -Path ./data
$new_array = @()
foreach ($file in $checkfile) {
    if ($file | Get-Content | Where-Object { $_ -match "Standard_B2pts_v2" }) {
        $new_array += $file.Name
    }
}
$new_array.Replace(".json", "") | ConvertTo-Json | Out-File -Path result.json
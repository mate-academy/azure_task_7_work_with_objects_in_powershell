$checkfile = Get-ChildItem -Path ./data
$new_array = @()
foreach ($file in $checkfile) {
    $new_obj = $file | Get-Content | ConvertFrom-Json
    if ($new_obj.Name -eq "Standard_B2pts_v2") {
        $new_array += $file.Name.Replace(".json", "")
    }
}
$new_array | ConvertTo-Json | Out-File -Path result.json
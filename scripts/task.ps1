$list_of_regions = @()
Get-ChildItem ..\data | ForEach-Object {
    $region = $_.BaseName
    Get-Content $_ | ConvertFrom-Json | ForEach-Object {
       if ($_.Name -eq "Standard_B2pts_v2") {
           $list_of_regions += $region
           return
       }
    }
}
$list_of_regions | ConvertTo-Json | Out-File -FilePath .\result.json
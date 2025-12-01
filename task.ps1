
$all_files = Get-ChildItem -Path data/
$regions = foreach ($file in $all_files){
    if (Get-Content $file | ConvertFrom-Json | Where-Object {$_.Name -eq 'Standard_B2pts_v2'})
    {$file.BaseName
}}
ConvertTo-Json($regions) | Set-Content -Path "result.json"


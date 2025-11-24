# Write your code here
$regions = @()

foreach($file in Get-ChildItem -Path ./data) {
    if (Get-Content -Path $file.FullName | ConvertFrom-Json | Where-Object {$_.Name -eq "Standard_B2pts_v2"}){
        $regions += $file.BaseName
        continue
    }
}
$regions | ConvertTo-Json | Out-File -FilePath ./result.json

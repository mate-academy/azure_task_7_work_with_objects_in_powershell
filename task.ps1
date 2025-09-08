# Write your code here
$files = Get-ChildItem -Path ".\data"
$regions = @()
foreach ($file in $files) {
    $jsonText = Get-Content $file.FullName -Raw
    $vmSizes = $jsonText | ConvertFrom-Json

    if ($vmSizes | Where-Object { $_.Name -eq "Standard_B2pts_v2" }) {
        $regions += $file.BaseName
    }
}
$regions | ConvertTo-Json | Out-File -FilePath result.json



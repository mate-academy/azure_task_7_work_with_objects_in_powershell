# Write your code here
$files = Get-ChildItem -Path "./data" -File -Recurse

$myList = @()

foreach ($file in $files) {
    $availableRegion = Get-Content -Raw -Path $file | ConvertFrom-Json
    $matchRegions = $availableRegion | Where-Object { $_.Name -eq "Standard_B2pts_v2" }
    if ($matchRegions) {
    $filename = $file.BaseName
    $myList += $filename
    }
}

$myList | ConvertTo-Json | Out-File -FilePath .\result.json
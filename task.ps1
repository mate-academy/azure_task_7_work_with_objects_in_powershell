# Write your code here
$location = Get-ChildItem -Path./data
$location_with_B2pts = @()
foreach ($loc in $location) {
    if (Get-Content $loc | ConvertFrom-Json | Where-Object {$_.name -eq "Standard_B2pts_v2"}) {
        $location_with_B2pts += $loc.BaseName
    }
}
$location_with_B2pts | ConvertTo-Json | Out-File "$PWD\result.json"

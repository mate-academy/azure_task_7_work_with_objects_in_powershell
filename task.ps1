# Write your code here
$result = @()
[string]$vmSizeName  = "Standard_B2pts_v2"

Get-ChildItem "data" | ForEach-Object {
    $vmSizes = Get-Content $_.FullName | ConvertFrom-Json

    $match = $vmSizes | Where-Object { $_.Name -eq $vmSizeName }

    if ($match) {
        $region = $_.Name.Replace(".json", "")
        $result += $region
    }
}

$result | ConvertTo-Json | Out-File -FilePath "result.json"
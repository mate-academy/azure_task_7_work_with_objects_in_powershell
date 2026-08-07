
$regionDataDirectory = "./data"
$regionDataFiles = Get-ChildItem $regionDataDirectory
$result = @()

foreach ($region in $regionDataFiles) {
    $regionData = Get-Content "$regionDataDirectory/$($region.Name)" | ConvertFrom-Json
    $foundSize = $regionData | Where-Object { $_.Name -eq "Standard_B2pts_v2" }

    if ($foundSize) {
        $result += $region.Name.Replace(".json", "")
    }
}

$result | ConvertTo-Json | Set-Content "./result.json"
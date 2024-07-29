# Write your code here

$pathToData = "./data"
$vmSize = "Standard_B2pts_v2"
$regionsWithSize = @()

$jsonFiles = Get-ChildItem -Path $pathToData -Filter "*.json"
foreach ($file in $jsonFiles) {
    $pathToFile = $file.FullName
    $vmTypes = Get-Content -Path $pathToFile | ConvertFrom-Json
    if ($vmTypes.Name -contains $vmSize) {
        $regionName = $file.BaseName.Replace('.json', '')
        $regionsWithSize += $regionName
    }
}
$regionsWithSize | ConvertTo-Json | Set-Content -Path "./result.json"

$dirPath = "./data"
$vmSizeToFind = "Standard_B2pts_v2"
$regionsWithVMSize = @()
$jsonFiles = Get-ChildItem -Path $dirPath -Filter "*.json"

foreach ($file in $jsonFiles) {
    $regionName = $file.BaseName.Replace('.json', '')
    $vmSizes = Get-Content -Path $file.FullName | ConvertFrom-Json

    if ($vmSizes.Name -contains $vmSizeToFind) {
        $regionsWithVMSize += $regionName
    }
}

$resultJson = $regionsWithVMSize | ConvertTo-Json -Depth 1
$outputFilePath = "./result.json"

Set-Content -Path $outputFilePath -Value $resultJson



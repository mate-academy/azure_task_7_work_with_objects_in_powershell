$directoryPath = "../data"

$vmSize = "Standard_B2pts_v2"

$regionsWithVmSize = @()

$jsonFiles = Get-ChildItem -Path $directoryPath -Filter "*.json"

foreach ($file in $jsonFiles) {
    $filePath = $file.FullName
    
    $vmSizes = Get-Content -Path $filePath | ConvertFrom-Json
    
    if ($vmSizes.Name -contains $vmSize) {
        $regionName = $file.BaseName.Replace('.json', '')

        $regionsWithVmSize += $regionName
    }
}

$regionsWithVmSize | ConvertTo-Json | Set-Content -Path "./result.json"

$dataPath = "./data"

$vmType = "Standard_B2pts_v2"

$regionsWithVmType = @()

$jsonFiles = Get-ChildItem -Path $dataPath -Filter "*.json"

foreach ($file in $jsonFiles) {
    $filePath = $file.FullName

    $vmTypes = Get-Content -Path $filePath | ConvertFrom-Json

    if ($vmTypes.Name -contains $vmType) {
        $regionName = $file.BaseName.Replace('.json', '')

        $regionsWithVmType += $regionName
    }
}

$regionsWithVmType | ConvertTo-Json | Set-Content -Path "./result.json"

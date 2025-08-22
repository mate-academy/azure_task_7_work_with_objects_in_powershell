$dataFiles = Get-ChildItem -Path "./data" -Filter "*.json"

$regionsWithVM = @()

$targetVMSize = "Standard_B2pts_v2"

foreach ($file in $dataFiles) {
    $jsonContent = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    foreach ($vmSize in $jsonContent) {
        if ($vmSize.name -eq $targetVMSize) {
            $regionName = $file.BaseName
            $regionsWithVM += $regionName
            break
        }
    }
}

$regionsWithVM | ConvertTo-Json | Set-Content -Path "./result.json"

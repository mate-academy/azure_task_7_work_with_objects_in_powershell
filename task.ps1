$dataDirectory = ".\data"
$regionsWithVmSize = @()
$jsonFiles = Get-ChildItem -Path $dataDirectory -Filter *.json
foreach ($file in $jsonFiles) {
    $regionName = $file.Name.Replace('.json', '')
    $vmSizes = Get-Content -Path $file.FullName | ConvertFrom-Json
    $vmSizeFound = $vmSizes | Where-Object { $_.name -eq "Standard_B2pts_v2" }

    if ($vmSizeFound) {
        $regionsWithVmSize += $regionName
    }
}

$regionsWithVmSize | ConvertTo-Json | Set-Content -Path ".\result.json"

Write-Host "Script executed successfully. Check 'result.json' for the list of available regions."

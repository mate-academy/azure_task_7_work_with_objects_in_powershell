$regions = @()

foreach ($regionFile in Get-ChildItem -Path ./data) {
    $fileData = $regionFile | Get-Content | ConvertFrom-Json
    $targetVmSize = $fileData | Where-Object {$_.Name -match "Standard_B2pts_v2"}

    if ($null -ne $targetVmSize) {
        $regions += $regionFile.Name.Replace(".json", "")
    }

}

$regions | ConvertTo-Json | Out-File -FilePath ./result.json
Write-Output "`u{1F973} Regions with Standard_B2pts_v2 VM size saved to result.json"
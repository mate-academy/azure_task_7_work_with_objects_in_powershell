$targetVmSize = 'Standard_B2pts_v2'
$dataFolderPath = Join-Path -Path $PSScriptRoot -ChildPath 'data'
$resultFilePath = Join-Path -Path $PSScriptRoot -ChildPath 'result.json'

$regions = @()
$files = Get-ChildItem -Path $dataFolderPath -File -Filter '*.json'

foreach ($file in $files) {
    $vmSizes = Get-Content -Path $file.FullName | ConvertFrom-Json
    $matchedVmSize = $vmSizes | Where-Object { $_.Name -eq $targetVmSize }

    if ($matchedVmSize) {
        $regions += $file.BaseName
    }
}

$regions | ConvertTo-Json | Set-Content -Path $resultFilePath

$dataPath = ".\data"
$vmSize = "Standard_B2pts_v2"
$resultRegions = @()

$filesList = Get-ChildItem -Path $dataPath

foreach ($file in $filesList) {
    $fileContent = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    if ($fileContent | Where-Object { $_.name -eq $vmSize }) {
        $resultRegions += $file.BaseName
    }
}

$resultFile = ".\result.json"
$resultRegions | ConvertTo-Json -Depth 1 | Out-File -FilePath $resultFile -Encoding utf8

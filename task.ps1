$TargetSize = "Standard_B2pts_v2"

$DataFolderPath = Join-Path $PSScriptRoot "data"
$ResultFilePath = Join-Path $PSScriptRoot "result.json"

$Files = Get-ChildItem -Path $DataFolderPath -Filter "*.json"
$Regions = @()

foreach ($File in $Files) {
    $VmSizes = Get-Content -Path $File.FullName -Raw |
        ConvertFrom-Json

    $FoundSize = $VmSizes |
        Where-Object { $_.Name -eq $TargetSize }

    if ($FoundSize) {
        $Regions += $File.BaseName
    }
}

$Regions |
    ConvertTo-Json |
    Set-Content -Path $ResultFilePath -Encoding utf8
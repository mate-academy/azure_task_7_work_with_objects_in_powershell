param()

$dataDirectory = Join-Path $PSScriptRoot "data"
$resultFilePath = Join-Path $PSScriptRoot "result.json"

if (-not (Test-Path -LiteralPath $dataDirectory)) {
    throw "Data directory not found: $dataDirectory"
}

$targetVmSizeName = "Standard_B2pts_v2"
$regionsWithTargetSize = @()

Get-ChildItem -LiteralPath $dataDirectory -Filter *.json -File | ForEach-Object {
    $file = $_
    try {
        $jsonText = Get-Content -LiteralPath $file.FullName -Raw
        $sizes = $jsonText | ConvertFrom-Json -Depth 100
        if ($sizes | Where-Object { $_.Name -eq $targetVmSizeName }) {
            $regionsWithTargetSize += $file.BaseName
        }
    }
    catch {
        Write-Warning "Failed to process file: $($file.FullName). Error: $($_.Exception.Message)"
    }
}

$regionsWithTargetSize | ConvertTo-Json | Out-File -LiteralPath $resultFilePath -Encoding UTF8
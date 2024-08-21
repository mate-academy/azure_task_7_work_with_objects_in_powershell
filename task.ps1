$inputPath = "$PWD/data/"
$outputPath = "$PWD/result.json"
$searchString = "Standard_B2pts_v2"

if (-Not (Test-Path -Path $inputPath)) {
    Write-Error "$inputPath does not exist."
    exit
}

$jsonFiles = Get-ChildItem -Path $inputPath -Filter *.json

$regionList = @()

foreach ($file in $jsonFiles) {
    $jsonContent = Get-Content -Path $file.FullName -Raw
    $jsonObject = $jsonContent | ConvertFrom-Json

    if ($jsonObject.Name -eq $searchString) {
        $regionList += $file.BaseName
    }
}

$regionList | ConvertTo-Json | Out-File -Path $outputPath

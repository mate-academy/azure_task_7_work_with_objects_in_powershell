# Write your code here

$files = Get-ChildItem -Path "data" -Filter "*.json"

$resultRegions = @()

$targetSize = "Standard_B2pts_v2"

foreach ($file in $files) {
    $jsonContent = Get-Content -Path $file.FullName | ConvertFrom-Json

    if ($jsonContent.name -contains $targetSize) {

        $regionName = $file.Name.Replace('.json', '')

        $resultRegions += $regionName
    }
}

$resultRegions | ConvertTo-Json | Set-Content -Path "result.json"
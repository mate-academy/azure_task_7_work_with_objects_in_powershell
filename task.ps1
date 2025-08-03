
$dataFolder = "C:\Users\ASION\azure_task_7_work_with_objects_in_powershell\data"


$matchingRegions = @()


Get-ChildItem -Path $dataFolder -Filter *.json | ForEach-Object {
    $file = $_
    $regionName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)


    $content = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json


    if ($content | Where-Object { $_.name -eq "Standard_B2pts_v2" }) {
        $matchingRegions += $regionName
    }
}

$outputPath = "C:\Users\ASION\azure_task_7_work_with_objects_in_powershell\result.json"

$matchingRegions | ConvertTo-Json -Depth 1 | Set-Content -Encoding UTF8 -Path $outputPath

Write-Host "Regions Find. Result saved to result.json"

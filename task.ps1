$targetVmSize = "Standard_B2pts_v2"
$dataFolder = "data"
$resultFile = "result.json"

$regionsWithVm = @()

Get-ChildItem -Path $dataFolder -Filter *.json | ForEach-Object {

    $file = $_
    $regionName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

    $jsonContent = Get-Content $file.FullName -Raw | ConvertFrom-Json

    $found = $jsonContent | Where-Object {
        $_.name -eq $targetVmSize
    }

    if ($found) {
        $regionsWithVm += $regionName
    }
}

$regionsWithVm | ConvertTo-Json -Depth 1 | Set-Content $resultFile
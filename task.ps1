$filePathes = Get-ChildItem -Path "./data"
$vmSize = "Standard_B2pts_v2"
$locationList = [System.Collections.Generic.List[string]]::new()

foreach($filePath in $filePathes)
{
    $filePathWithoutExtension = Split-Path -Path $filePath -LeafBase
    $jsonData = Get-Content $filePath.FullName -Raw
    $decodedObject = ConvertFrom-Json -InputObject $jsonData

    if($decodedObject.Name -eq $vmSize){
        $locationList.Add($filePathWithoutExtension)
    }
}

$locationList | ConvertTo-Json | Out-File -Path./result.json
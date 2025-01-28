$directoryPath = "$PSScriptRoot\data"
$resultFilePath = "$PSScriptRoot\result.json"

$result = @()

foreach ($file in Get-ChildItem -Path $directoryPath -Filter *.json -File) {
    if (Select-String -Path $file.FullName -Pattern "Standard_B2pts_v2" -Quiet) {
        $result += [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    }
}

$result | ConvertTo-Json | Out-File -FilePath $resultFilePath -Encoding UTF8

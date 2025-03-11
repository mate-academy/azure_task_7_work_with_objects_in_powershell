$dirpath = "$PSScriptRoot\data"
$resultfile = "$PSScriptRoot\result.json"

$regions = @()

$files = Get-ChildItem -Path $dirpath -Filter "*.json" -File

foreach ($file in $files) {
    $region = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    if (Select-String -Path $file.FullName -Pattern "Standard_B2pts_v2" -Quiet) {
        $regions += $region
    }
}

$regions | ConvertTo-Json | Out-File -FilePath $resultfile -Encoding UTF8

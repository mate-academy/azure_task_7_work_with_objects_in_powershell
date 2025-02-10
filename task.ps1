$repofile = Get-ChildItem -Path "./data/*.json"
$sizevm = "Standard_B2pts_v2"
$resultfile = @()

foreach ($file in $repofile) {
    $jsondata = Get-Content -Path $file.FullName | ConvertFrom-json
    if (Select-String -Path $file.FullName -Pattern $sizevm -Quiet) {
        $region = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $resultfile += $region
    }
}
 $resultfile | ConvertTo-Json | Out-File -Path ./result.json -Encoding UTF8

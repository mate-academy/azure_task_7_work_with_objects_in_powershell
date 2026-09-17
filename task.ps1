$regions = @()

$files = Get-ChildItem -Path ./data
foreach ($file in $files) {
    <# $datas is tdata item #>
    $sizes = Get-Content -Path $file.FullName | ConvertFrom-Json
    $region = $sizes | Where-Object { $_.Name -eq 'Standard_B2pts_v2' }
    if ( $null -ne $region ) {
        $regionName = $file.Name.Replace('.json', '')
        $regions += $regionName
    }
}
$regions | ConvertTo-Json | Out-File -Path ./result.json
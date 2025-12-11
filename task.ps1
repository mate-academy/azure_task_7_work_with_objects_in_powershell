$vmSize = "Standard_B2pts_v2"
$Path = "./data/"
$regions = @()

foreach ($file in Get-ChildItem -Path $Path -Filter *.json) {
    $json = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
    $match = $json | Where-Object { $_.name -eq $vmSize }
    if ($match) {
        $regionName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $regions += $regionName
    }
}

$regions | ConvertTo-Json | Set-Content "result.json"

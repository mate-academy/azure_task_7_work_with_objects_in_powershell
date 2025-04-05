$repoPath = Get-Location

$regionsWithVM = @()

Get-ChildItem -Path $repoPath -Filter *.json | ForEach-Object {
    $file = $_
    try {
        $jsonContent = Get-Content $file.FullName -Raw | ConvertFrom-Json

        foreach ($obj in $jsonContent) {
            if ($obj.name -eq "Standard_B2pts_v2") {
                $region = if ($obj.PSObject.Properties.Name -contains "location") {
                    $obj.location
                } else {
                    $file.BaseName
                }

                if (-not ($regionsWithVM -contains $region)) {
                    $regionsWithVM += $region
                }

                break
            }
        }
    } catch {
        Write-Warning "Помилка при обробці файлу: $($file.Name)"
    }
}

$regionsWithVM | ConvertTo-Json -Depth 1 | Set-Content -Encoding UTF8 "$repoPath\result.json"

Write-Host "Результати збережено у: $repoPath\result.json"

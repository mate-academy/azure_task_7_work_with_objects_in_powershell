$PathData = Get-ChildItem ./data
$ResultList = @()

foreach ($file in $PathData)
{
    $content = Get-Content $file.FullName | ConvertFrom-Json
    foreach ($data in $content)
    {
        if ($data.Name -eq "Standard_B2pts_v2")
        {
            $ResultList += $file.BaseName
        }
    }
    $ResultList | ConvertTo-Json | Out-File -FilePath ./result.json -Encoding utf8
    $ResultList | ForEach-Object { Write-Host $_}
}


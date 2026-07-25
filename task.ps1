$regions = @()

Get-ChildItem "$PWD/data" | ForEach-Object {
    $file = $_
    $file_data = Get-Content $file.FullName | ConvertFrom-Json

    $match = $file_data | Where-Object { $_.Name -eq "Standard_B2pts_v2" }
    if ($match) {
        $regions += $file.Name.Replace('.json', '')
    }
}

$regions | ConvertTo-Json | Set-Content "$PWD/result.json"

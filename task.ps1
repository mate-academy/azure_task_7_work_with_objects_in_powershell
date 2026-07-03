$result = @()

$files = Get-ChildItem "./data"

foreach ($file in $files) {

    $data = Get-Content $file.FullName | ConvertFrom-Json

    $found = $data | Where-Object { $_.Name -eq "Standard_B2pts_v2" }

    if ($found) {

        $region = $file.Name.Replace(".json", "")

        $result += $region
    }
}

$result | ConvertTo-Json -Compress | Out-File "./result.json"
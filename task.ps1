$regions = Get-ChildItem -Path data
$result = @()

foreach ($region in $regions) {
    $jsonObject = Get-Content $region.FullName -Raw | ConvertFrom-Json

    foreach ($vm in $jsonObject) {

        if ($vm.Name -eq "Standard_B2pts_v2") {
            $result += $region.Name.Replace('.json', '')
        }

    }
}

$result | ConvertTo-Json | Set-Content -Path "result.json"

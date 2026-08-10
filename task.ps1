$Path = "./data"

$FoundRegions = Get-ChildItem -Path $Path -Filter *.json | ForEach-Object {
    $MatchingSize = Get-Content -Raw -Path $_.FullName | ConvertFrom-Json | Where-Object { $_.Name -eq "Standard_B2pts_v2" }

    if($MatchingSize) {
        $RegionName = $_.Name.Replace(".json", "")

        $RegionName
    }
}

$FoundRegions | ConvertTo-Json | Set-Content -Path "./result.json"
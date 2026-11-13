$needType = 'Standard_B2pts_v2'
$regions = @()
$dataFolder = './data'
$result = './result.json'


foreach($file in Get-ChildItem -Path $dataFolder) {
    $vms = Get-Content $file.FullName -Raw | ConvertFrom-Json

    foreach ($vm in $vms) {
        if ($vm.name -eq $needType) {
            $regions += $file.BaseName
            break
        }
    }
}

ConvertTo-Json -InputObject $regions | Set-Content $result
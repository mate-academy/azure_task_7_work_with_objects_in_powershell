# Write your code here

$list_of_files = Get-ChildItem .\data
$array_of_rigions = @()

foreach ($file in $list_of_files) {
    $content = Get-Content -Path $file.FullName | ConvertFrom-Json

    foreach ($item in $content) {
        if ($item.Name -eq 'Standard_B2pts_v2') {
            $array_of_rigions = $array_of_rigions + $file.Name.Split(".")[0]
            break
        }
    }
}

$array_of_rigions | ConvertTo-Json | Out-File ./result.json

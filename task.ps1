$array = Get-ChildItem -Path ./data -Filter *.json | Select-Object -ExpandProperty BaseName
$my_array = @()
foreach ($name in $array) {
    $content = Get-Content ./data/$name.json | ConvertFrom-Json | Where-Object {$_.Name -eq 'Standard_B2pts_v2'}
    if ($content)
    {
        $my_array += $name
    }
}

$json = $my_array | ConvertTo-Json -Depth 1
$json | Out-File ./result.json -Encoding utf8

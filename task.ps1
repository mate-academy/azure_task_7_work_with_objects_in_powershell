$files = Get-ChildItem -Path ./data
$result = @()
foreach ($element in $files) {
    $json_text = Get-Content $element -Raw
    $object = ConvertFrom-Json -InputObject $json_text
    foreach ($string in $object) {
        if ($string.Name -eq "Standard_B2pts_v2"){
            $result = $result + $element.BaseName
        }
    }
}
$result = ConvertTo-Json -InputObject $result
Out-File -InputObject $result -Path ./result.json
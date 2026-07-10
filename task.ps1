$files = Get-ChildItem -Path C:/Users/User/PycharmProjects/Mate-Academy/azure_task_7_work_with_objects_in_powershell/data
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
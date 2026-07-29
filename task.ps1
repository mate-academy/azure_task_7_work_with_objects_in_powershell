$result_list = @()
$list_files = Get-ChildItem ./data
foreach ($element in $list_files) {
  $objects = Get-Content $element.FullName -Raw | ConvertFrom-Json
  foreach ($object in $objects) {
        if ($object.Name -eq "Standard_B2pts_v2") {
            $result_list += $element.BaseName
            break
        }
    }
}
$result_list | ConvertTo-Json | Out-File -Path ./result.json
$result_list = @()
$list_files = Get-ChildItem ./data
foreach ($element in $list_files) {
  $content = Get-Content $element.FullName -Raw
  if ($content -match "Standard_B2pts_v2") {
    $stringVariable = $element.Name.Replace('.json', '')
    $result_list += $stringVariable
  }
}
$result_list | ConvertTo-Json | Out-File -Path ./result.json
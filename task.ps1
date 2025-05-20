# Write your code here
$data = "C:\Users\orest\Desktop\devops\azure_task_7_work_with_objects_in_powershell\data"
$files = Get-ChildItem -Path $data
$result_file = @()
foreach ($currentItemName in $files) {
    $variable = Get-Content $currentItemName | ConvertFrom-Json
    $output_data = $variable
    foreach($item in $output_data) {
      if ($item.Name -eq 'Standard_B2pts_v2') {
        $result_file += $currentItemName.BaseName
      }
    }

}
$result_file | ConvertTo-Json | Out-File -Path ./result.json
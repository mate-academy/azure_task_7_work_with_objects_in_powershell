$VM_SIZE = "Standard_B2pts_v2"
$RESULT_FILE_NAME = "result.json"

$files = Get-ChildItem -Path ./data/ -File
$result = @()

foreach($file in $files) {
  $content = Get-Content -Path $file.FullName | ConvertFrom-Json
  if ($content | Where-Object { $_.Name -eq $VM_SIZE }) {
    $result += $file.Name.Replace(".json", "")
  }
}

$result | ConvertTo-Json | Set-Content -Path $RESULT_FILE_NAME
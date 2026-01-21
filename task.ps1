$files = Get-ChildItem -Path data
$result = @()
foreach ($file in $files) {
  if (Get-Content $file | ConvertFrom-Json | Where-Object {$_.Name -eq "Standard_B2pts_v2"}) {
    $result += $file.BaseName
    # $file | Get-Member
  }
}

$result | ConvertTo-Json | Out-File -FilePath "result.json"
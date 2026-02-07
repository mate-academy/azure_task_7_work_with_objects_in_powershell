$files = Get-ChildItem -Path .\data\ -Filter *.json
@(foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName | ConvertFrom-Json
    foreach ($item in $content) {
      if ($item.Name -eq "Standard_B2pts_v2") {
        $file.Name.Replace('.json', '')
        break
      }
    }
}) | ConvertTo-Json | Out-File -FilePath "$PWD/result.json" -Encoding utf8

$files = Get-ChildItem -Path data/
$result = @()
foreach ($file in $files) {

    $data = Get-Content -Raw -Path "./data/$($file.Name)" | ConvertFrom-Json | Where-Object { $_.name -eq "Standard_B2pts_v2" }
    if ($data) {
        $stringVariable = $file.Name.Replace('.json', '')

        $result = $result + $stringVariable

    }
}

$result | ConvertTo-Json | Out-File -FilePath "result.json"
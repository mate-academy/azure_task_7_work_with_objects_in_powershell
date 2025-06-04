$folder = Get-ChildItem -Path .\data
$regions = @()
foreach ($file in $folder) {
	[string]$filename = $file.Name
	$array = Get-Content -Path "data/$filename" | ConvertFrom-Json
	$check = $array | Where-Object { $_.Name -eq "Standard_B2pts_v2" }
	if ($check) {
		$regionName = $filename.Replace(".json", "")
		$regions += $regionName
	}
}
$regions | ConvertTo-Json | Out-File -FilePath "result.json"
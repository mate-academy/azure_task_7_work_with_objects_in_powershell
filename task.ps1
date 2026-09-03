# Write your code here
$regions = @()
$files = Get-ChildItem -Path "./data" -Filter "*.json"

foreach ($file in $files) {
	$content = Get-Content -Path $file.FullName | ConvertFrom-Json
	if ($content | Where-Object { $_.Name -eq "Standard_B2pts_v2" }){
		$regionName = $file.Name.Replace('.json', '')
		$regions += $regionName
	}
}
$regions | ConvertTo-Json | Set-Content -Path "result.json"
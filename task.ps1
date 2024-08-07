# Write your code here
$VMSize = "Standard_B2pts_v2"

$result = @()

$files = Get-ChildItem -Path ./data

foreach ($file in $files) {
	$content = Get-Content -Path $file | ConvertFrom-Json
	foreach ($object in $content) {
		if ($object.Name -eq $VMSize) {
			$result += $file.BaseName
		}
	}
}

$result | ConvertTo-Json | Set-Content -Path ".\result.json"
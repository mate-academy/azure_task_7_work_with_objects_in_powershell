# Write your code here
$array = Get-ChildItem -Path .\data
$result = @()
$object = "Standard_B2pts_v2"
foreach ($path in $array) {
    $subject = Get-Content -Path $path | ConvertFrom-Json
    if ($subject | Where-Object {$_.Name -eq $object}) {
        $file = Split-Path $path -Leaf
        $result += $file.Replace('.json', '')
    }
}
$result | ConvertTo-Json | Out-File -Path ./result.json


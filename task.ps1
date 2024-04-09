$files = Get-ChildItem -Path "$PWD/data"


$resultRegions = @()
foreach ($file in $files) {
   $region = $file.Name.Replace('.json', '')


   $sizes = Get-Content -Path $file.FullName | ConvertFrom-Json


   $size = $sizes | Where-Object {$_.Name -eq 'Standard_B2pts_v2'}


   if ($size) {
       $resultRegions += $region
   }
}


$resultRegions | ConvertTo-Json | Out-File "$PWD/result.json"
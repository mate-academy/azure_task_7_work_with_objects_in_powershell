# Initialize an empty array to store regions where Standard_B2pts_v2 is available
$regionsWithB2ptsV2 = @()

# Get all JSON files from the data directory
$jsonFiles = Get-ChildItem -Path "data" -Filter "*.json"

# Loop through each JSON file
foreach ($file in $jsonFiles) {
    # Read the JSON content and convert it to PowerShell objects
    $vmSizes = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
    
    # Search for the VM size Standard_B2pts_v2 in the current file
    $targetVmSize = $vmSizes | Where-Object { $_.Name -eq "Standard_B2pts_v2" }
    
    # If the VM size was found, add the region name to the result list
    if ($targetVmSize) {
        # Get region name by removing the .json extension from the file name
        $regionName = $file.Name.Replace('.json', '')
        $regionsWithB2ptsV2 += $regionName
    }
}

# Export the result list to result.json in JSON format
$regionsWithB2ptsV2 | ConvertTo-Json | Set-Content -Path "result.json"

# Display the results
Write-Host "Found Standard_B2pts_v2 in $($regionsWithB2ptsV2.Count) regions:"
$regionsWithB2ptsV2 | ForEach-Object { Write-Host "  - $_" }

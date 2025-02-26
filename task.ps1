# Get a list of all JSON files in the "data" folder
$files = Get-ChildItem -Path ".\data" -Filter "*.json"

# Array to store regions where the VM size "Standard_B2pts_v2" is available
$availableRegions = @()

# Loop through each file
foreach ($file in $files) {
    # Read the file content and convert it from JSON to PowerShell objects
    $content = Get-Content -Path $file.FullName | ConvertFrom-Json

    # Check if the required VM size exists in the list of available sizes
    if ($content -contains "Standard_B2pts_v2") {
        # Add the region name to the list (removing ".json" from the file name)
        $region = $file.BaseName
        $availableRegions += $region
    }
}

# Export the list of regions to a JSON file result.json
$availableRegions | ConvertTo-Json -Depth 1 | Set-Content -Path ".\result.json"

Write-Host "Processing complete. Check result.json for output."

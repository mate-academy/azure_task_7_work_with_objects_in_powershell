# task.ps1

# Initialize an empty array to hold the regions
$regions = @()

# Get all JSON files in the data directory
$jsonFiles = Get-ChildItem -Path ".\data" -Filter "*.json"

# Loop through each JSON file
foreach ($file in $jsonFiles) {
    # Convert JSON data to a list of objects
    $vmSizes = Get-Content -Path $file.FullName | ConvertFrom-Json

    # Check if the VM size 'Standard_B2pts_v2' exists in the list
    if ($vmSizes | Where-Object { $_.name -eq 'Standard_B2pts_v2' }) {
        # Get the region name by removing the '.json' suffix
        $regionName = $file.Name.Replace('.json', '')
        # Add the region name to the result list
        $regions += $regionName
    }
}

# Export the result list to result.json
$regions | ConvertTo-Json | Set-Content -Path ".\result.json"
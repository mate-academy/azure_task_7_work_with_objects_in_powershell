# Write your code here

# Define the path to the directory containing JSON files
$dataPath = "./data"

# Define the VM size we are looking for
$vmType = "Standard_B2pts_v2"

# Initialize an array to hold regions where the VM size is available
$regionsWithVmType = @()

# Loop through each JSON file in the data directory
$jsonFiles = Get-ChildItem -Path $dataPath -Filter "*.json"
foreach ($file in $jsonFiles) {
    $filePath = $file.FullName
    $vmTypes = Get-Content -Path $filePath | ConvertFrom-Json
    # Check if the VM size exists in the list of VM types
    if ($vmTypes.Name -contains $vmType) {
        $regionName = $file.BaseName.Replace('.json', '')
        # Add the region name to the result list if VM type is found
        $regionsWithVmType += $regionName
    }
}
# Save the result to the result.json file
$regionsWithVmType | ConvertTo-Json | Set-Content -Path "./result.json"
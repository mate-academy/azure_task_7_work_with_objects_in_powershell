# Write your code here
$dataPath = ".\data"

# Define the VM size we are looking for
$vmSizeToFind = "Standard_B2pts_v2"

# Initialize an array to hold regions where the VM size is available
$regionsWithVmSize = @()

# Loop through each JSON file in the data directory
Get-ChildItem -Path $dataPath -Filter *.json | ForEach-Object {
    $file = $_.FullName

    # Extract region name from the file name (assuming the file name is the region name)
    $regionName = [System.IO.Path]::GetFileNameWithoutExtension($file)

    # Read and convert the JSON file content to PowerShell objects
    $vmSizes = Get-Content -Path $file | ConvertFrom-Json

    # Check if the VM size exists in the list of VM sizes
    if ($vmSizes -contains $vmSizeToFind) {
        # Add the region name to the result list if VM size is found
        $regionsWithVmSize += $regionName
    }
}

# Export the result list to a JSON file
$resultFilePath = ".\result.json"
$regionsWithVmSize | ConvertTo-Json | Set-Content -Path $resultFilePath

Write-Output "Script completed. The regions with the VM size '$vmSizeToFind' are saved in '$resultFilePath'."
$RegionFiles = Get-ChildItem .\data\
$list = @()

foreach ($RegionFile in $RegionFiles)
{
  $Sizes = Get-Content $RegionFile -Raw | ConvertFrom-Json

  foreach ($Size in $Sizes)
    {
      if ($Size.Name -eq "Standard_B2pts_v2")
        {
          $RegionName = $RegionFile.BaseName
          $list += $RegionName
        }
    }
}

$JsonList = ConvertTo-Json -InputObject $list
Set-Content -Path ".\result.json" -Value $JsonList

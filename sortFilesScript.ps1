# Paths
$sourcePath = "C:\Tracks\"
$targetPath = "C:\Sorted tracks\"

# Get files from source path
$files = Get-ChildItem $sourcePath -Recurse | where {!$_.PsIsContainer}

# Iterate files and copy to target path sub folders
foreach ($file in $files)
{
    try 
    {
        # Format sub folder for file 
        $subFolderStructure = $file.LastWriteTime.Year.ToString() + "\" + $file.LastWriteTime.Month.ToString()

        # Format full path for file
        $fullPath = "$targetPath$subFolderStructure"

        # Create folder if it doesn't exist yet
        if (!(Test-Path $fullPath))
        {
             New-Item $fullPath -type directory 
        }
 
        # Copy File to new location
        $file | Copy-Item -Destination $fullPath

        # Print success message
        Write-Host "$file copied to folder $fullPath" -ForegroundColor cyan
    }
    
    catch 
    {
       # Print error message if copying fails
       Write-Host "Error copying file $file" -ForegroundColor red
    }

}
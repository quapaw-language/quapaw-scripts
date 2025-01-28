# Set source folder
$sourceFolder = "D:\quadict_audio\.files_to_sort"

# Set destination folder possibilities
$destAB = "D:\quadict_audio\[ab] anna_beaver"
$destACG = "D:\quadict_audio\[acg] alice_crawfish_gilmore"
$destFGR = "D:\quadict_audio\[fgr] fannie_goodeagle_richards"
$destLQ = "D:\quadict_audio\[lq] louis_quapaw"
$destMLR = "D:\quadict_audio\[mlr] mary_lane_redeagle"
$destMS = "D:\quadict_audio\[ms] maude_supernaw"
$destMW = "D:\quadict_audio\[mw] mary_wilson"
$destOM = "D:\quadict_audio\[om] odestine_mcwatters"

# Iterate only .mp3 files from source folder
$mp3Files = Get-ChildItem -Path $sourceFolder -Filter *.mp3

# Loop through each .mp3 file
foreach ($file in $mp3Files) {
    # Retrieve first two characters from each .mp3 filename
    $prefix = $file.Name.Substring(0, 2).ToLower()

    # Map the prefix to the corresponding destination folder
    switch ($prefix) {
        "ab" { $destinationFolder = $destAB }
        "ac" { $destinationFolder = $destACG }
        "fg" { $destinationFolder = $destFGR }
        "lq" { $destinationFolder = $destLQ }
        "ml" { $destinationFolder = $destMLR }
        "ms" { $destinationFolder = $destMS }
        "mw" { $destinationFolder = $destMW }
        "om" { $destinationFolder = $destOM }
        default { 
            Write-Host "No matching folder found for $($file.Name)"
            continue
        }
    }

     # Verify destination folder existence
    if (-not (Test-Path -Path $destinationFolder)) {
        Write-Host "Destination folder not found for $($file.Name)."
    }

    # Move the file to the folder
    $destinationPath = Join-Path -Path $destinationFolder -ChildPath $file.Name
    Move-Item -Path $file.FullName -Destination $destinationPath

    Write-Host "Moved $($file.Name) to $destinationFolder"
}
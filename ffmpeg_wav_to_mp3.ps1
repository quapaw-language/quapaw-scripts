# Prompt for folder path containing .wav files.
$sourceFolder = Read-Host 'Input source folder path for .wav files.'

# Prompt destination path for converted .mp3 files.
$destFolder = Read-Host 'Input destination folder path for converted .mp3 files.'

# Test the destination folder exists, if not, create it.
if (-not (Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destFolder
}

# Iterate .wav files from the source folder
$wavFiles = Get-ChildItem -Path $sourceFolder -Filter *.wav

# Loop through each .wav file
foreach ($wavFile in $wavFiles) {
    # Define the output .mp3 file path
    $outputFile = Join-Path -Path $destFolder -ChildPath ($wavFile.BaseName + ".mp3")
    
    # Build the FFmpeg command to convert to .mp3
    $ffmpegCommand = "ffmpeg -i `"$($wavFile.FullName)`" -vn -ar 44100 -ac 2 -b:a 320k `"$outputFile`""

    # Execute and output command
    Write-Host "Converting $($wavFile.Name) to $outputFile"
    Invoke-Expression $ffmpegCommand
}

Write-Host "File conversion is complete for inputted path."

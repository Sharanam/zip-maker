# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# for signing the script and allowing it to run

$folderPath = "./files"
$filesPerZip = 30
$outputFolder = "./opfiles"
$allFiles = Get-ChildItem -Path $folderPath
if ($allFiles.Count -eq 0) {
    Write-Host "No files found in the specified folder."
    exit
}

$numberOfZips = [math]::ceiling($allFiles.Count / $filesPerZip)
if (-not (Test-Path $outputFolder)) {
    New-Item -ItemType Directory -Force -Path $outputFolder
}

for ($i = 0; $i -lt $numberOfZips; $i++) {
    $startIdx = $i * $filesPerZip
    $endIdx = ($i + 1) * $filesPerZip - 1
    if ($endIdx -ge $allFiles.Count) {
        $endIdx = $allFiles.Count - 1
    }
    $zipFileName = Join-Path -Path $outputFolder -ChildPath ("$($i + 1).zip")
    $filesToZip = $allFiles[$startIdx..$endIdx].FullName
    Compress-Archive -Path $filesToZip -DestinationPath $zipFileName -Force
    Write-Host "Zip archive created successfully: $zipFileName"
}

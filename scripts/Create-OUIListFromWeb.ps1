# Get the latest OUI list from IEEE website
$LatestOUIs = (Invoke-WebRequest -Uri "https://standards-oui.ieee.org/oui/oui.txt").Content

# Create an empty string to store the output
$Output = ""

# Loop through each line in the latest OUI list
foreach($Line in $LatestOUIs -split '[\r\n]')
{
    # Check if the line starts with a 6 character hexadecimal number
    if($Line -match "^[A-F0-9]{6}")
    {        
        # Line looks like: 2405F5     (base 16)		Integrated Device Technology (Malaysia) Sdn. Bhd.
        # Replace multiple spaces with a single space, replace (base 16) with | and trim the line
        $Output += ($Line -replace '\s+', ' ').Replace(' (base 16) ', '|').Trim() + "`n"
    }
}

# Save the output to a file
Out-File -InputObject $Output -FilePath "$PSScriptRoot\Resources\oui.txt"

# Create constants
Set-Variable PATH -Option ReadOnly -Value #your exe path here
Set-Variable TAB -Option ReadOnly -Value '{TAB}'
Set-Variable SHIFT_TAB -Option ReadOnly -Value '+{TAB}'
Set-Variable ENTER -Option ReadOnly -Value '{ENTER}'

# Start program
Write-Host "Step 1: Launching app"
Start-Process $path
Start-Sleep -Seconds 1
$program = Get-Process -Name sk_server_registration

# Go to and press "Read Device" Button
Write-Host "Step 2: Waiting for things to finish somewhere else"
keySend -button $TAB -presses 9 -sleep 3


# Go to and press "Send to Server" Button.
Write-Host "Step 3: Pinging the server"
keySend -button $SHIFT_TAB -presses 1 -sleep 3

# Acknowledge the sent message
Write-Host "Step 4: Acknowledging the send"
keySend -button $ENTER -presses 0 -sleep 0
#>

# Clean up constants
Write-Host "Step 5: Cleaning up..."
Stop-Process $program
Remove-Variable TAB -Force
Remove-Variable SHIFT_TAB -Force
Remove-Variable ENTER -Force
Remove-Variable PATH -Force


<#
.Synopsis
   Press a key a given number of times
#>
function keySend
{
    Param
    (
        [String]$button,
        [Int]$presses,
        [Int]$sleep
    )

    for ($i = 0; $i -lt $presses; $i++)
    {
        "  pressing $button" + ": $i"
        [System.Windows.Forms.SendKeys]::SendWait($button);
    }
    Start-Sleep -Seconds 1
    "  pressing $ENTER"
    [System.Windows.Forms.SendKeys]::SendWait($ENTER);
    Write-Host "  Waiting for $sleep seconds"
    Start-Sleep -Seconds $sleep
}
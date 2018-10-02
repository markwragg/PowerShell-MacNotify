Class SoundNames : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {

        $SoundNames = ForEach ($SoundPath in '/System/Library/Sounds/','/Library/Sounds','~/Library/Sounds') {
            If (Test-Path $SoundPath) {
                (Get-ChildItem $SoundPath).BaseName
            }
        }
        return [string[]] $SoundNames
    }
}
Function Invoke-MacNotification {
    <#
        .SYNOPSIS
            Triggers a notification to appear in OSX with the specified message and optional title, subtitle and sound alert.

        .DESCRIPTION
            This cmdlet is a PowerShell wrapper for the applescript 'display notification' command to trigger a custom notification
            to be displayed on OSX.

        .PARAMETER Message
            The message text you want to appear in the notification. This parameter is mandatory.

        .PARAMETER Title
            Optional: The title text you want to appear in the notification.

        .PARAMETER Message
            Optional: The subtitle text you want to appear in the notification.

        .PARAMETER Sound
            OptionaL: The alert sound you want to play when the notification appears. Must be one of the sounds from the default alert
            sounds paths: '/System/Library/Sounds/','/Library/Sounds','~/Library/Sounds'.

        .EXAMPLE
            Invoke-MacNotification -Message 'Hello!'

        .EXAMPLE
            Invoke-MacNotification -Message 'Hello! -Title 'Hello Message'

        .EXAMPLE
            Invoke-MacNotification -Message 'Hello!' -Sound 'Ping'

        .EXAMPLE
            1,2,3 | Invoke-MacNotification -Title 'Numbers'

    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory,ValueFromPipeline,Position=0)]
        [String[]]
        $Message,

        [String]
        $Title = 'PowerShell Notification',

        [String]
        $Subtitle,

        [ValidateSet([SoundNames])]
        [String]
        $Sound
    )
    Begin {
    }
    Process {
        ForEach ($MessageText in $Message) {
            $CommandString = "display notification \`"$MessageText\`""
            if ($Title)    { $CommandString = $CommandString + " with title \`"$Title\`""}
            if ($Subtitle) { $CommandString = $CommandString + " subtitle \`"$Subtitle\`""}
            if ($Sound)    { $CommandString = $CommandString + " sound name \`"$Sound\`""}

            If ($PSCmdlet.ShouldProcess('Invoke-AppleScript',$CommandString)) {
                Invoke-AppleScript $CommandString
            }
        }
    }
}
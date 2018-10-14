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
Function Invoke-AlerterNotification {
    <#
        .SYNOPSIS
            Triggers an alerter notification to appear in OSX with the specified message and optional title, subtitle and sound alert.

        .DESCRIPTION
            This cmdlet is a PowerShell wrapper for the application 'alerter' command to trigger a custom notification
            to be displayed on OSX and handle a response/action.

        .PARAMETER Message
            The message text you want to appear in the notification. This parameter is mandatory.

        .PARAMETER Title
            Optional: The title text you want to appear in the notification.

        .PARAMETER Subtitle
            Optional: The subtitle text you want to appear in the notification.

        .PARAMETER Sound
            OptionaL: The alert sound you want to play when the notification appears. Must be one of the sounds from the default alert
            sounds paths: '/System/Library/Sounds/','/Library/Sounds','~/Library/Sounds'.

        .PARAMETER Timeout
                    Optional: Number of seconds to wait before dismissing the notification automatically. Default: waits indefinitely.

        .PARAMETER AppIcon
                    Optional: The path or URL to an image to display as the application icon for the notification.

        .EXAMPLE
            Invoke-AlerterNotification -Message 'Hello!'

        .EXAMPLE
            Invoke-AlerterNotification -Message 'Hello! -Title 'Hello Message' -Subtitle ':)' -Timeout 30 -AppIcon 'http://url.to/an/icon.png'

        .EXAMPLE
            Invoke-AlerterNotification -Message 'Hello!' -Sound 'Ping'

        .EXAMPLE
            1,2,3 | Invoke-AlerterNotification -Title 'Numbers'
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
        $Sound,

        [Int32]
        $Timeout,

        [String]
        $AppIcon
    )
    Begin {
    }
    Process {
        ForEach ($MessageText in $Message) {
            $CommandString = "-message '$MessageText'"
            if ($Title)    { $CommandString = $CommandString + " -title '$Title'"}
            if ($Subtitle) { $CommandString = $CommandString + " -subtitle '$Subtitle'"}
            if ($Sound)    { $CommandString = $CommandString + " -sound '$Sound'"}
            if ($Timeout)  { $CommandString = $CommandString + " -timeout $Timeout"}
            if ($AppIcon)  { $CommandString = $CommandString + " -appIcon '$AppIcon'"}

            If ($PSCmdlet.ShouldProcess("alerter $CommandString")) {
                Invoke-Alerter -Command $CommandString
            }
        }
    }
}
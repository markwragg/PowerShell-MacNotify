Function Invoke-Alerter {
    <#
        .SYNOPSIS
            Executes an alert string via Alerter.
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [String]
        $Command
    )
    Begin {
    }
    Process {
        If ($PSCmdlet.ShouldProcess('alerter',$Command)){
            Invoke-Expression "$PSScriptRoot/../Bin/alerter $Command"
        }
    }
}
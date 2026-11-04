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
        $CommandPath = (Resolve-Path (Join-Path -Path $MyInvocation.MyCommand.Module.ModuleBase -ChildPath 'Bin/alerter')).Path
    }
    Process {
        If ($PSCmdlet.ShouldProcess('Invoke-Expression',"$CommandPath $Command")){
            Invoke-Expression "$CommandPath $Command"
        }
    }
}
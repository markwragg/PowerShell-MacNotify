$Public = @( Get-ChildItem -Path "$PSScriptRoot/Public/*.ps1" -Recurse )
$Private = @( Get-ChildItem -Path "$PSScriptRoot/Private/*.ps1" -Recurse )

@($Public + $Private) | ForEach-Object {
    try {
        . $_.FullName
    }
    catch {
        Write-Error -Message "Failed to import function $($_.FullName): $_"
    }
}

# Chek for and add execute permission to alerter if it's missing.
$AlerterPath = Resolve-Path "$PSScriptRoot/Bin/alerter"

if (-not (bash -c "test -x $AlerterPath && echo 1")) {
    bash -c "chmod +x $AlerterPath"
}

Export-ModuleMember -Function $Public.Basename

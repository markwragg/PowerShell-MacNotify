BeforeAll {
    $Root = "$PSScriptRoot/.."
    $Module = 'MacNotify'

    Get-Module $Module | Remove-Module -Force
    Import-Module "$Root/$Module" -Force
}

Describe 'Invoke-AppleScript' {
    It 'Should not invoke osascript when -WhatIf is used' {
        { InModuleScope MacNotify { Invoke-AppleScript -Command 'display notification "hi"' -WhatIf } } | Should -Not -Throw
    }
}

BeforeAll {
    $Root = "$PSScriptRoot/.."
    $Module = 'MacNotify'

    Get-Module $Module | Remove-Module -Force
    Import-Module "$Root/$Module" -Force

    # Mocked here (BeforeAll), not inline in the Describe body -- Pester's discovery/run split
    # means a Mock registered directly in a Describe/Context only exists during discovery and is
    # gone again by the time the It blocks actually run.
    Mock -ModuleName $Module Invoke-Expression {}
}

Describe 'Invoke-Alerter' {
    It 'Should resolve the bundled alerter binary and invoke it with the given command' {
        InModuleScope MacNotify {
            Invoke-Alerter -Command '-message "hi" -json' | Out-Null
        }

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Expression -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -match '[\\/]Bin[\\/]alerter -message "hi" -json$'
        }
    }

    It 'Should not invoke the alerter binary when -WhatIf is used' {
        InModuleScope MacNotify {
            Invoke-Alerter -Command '-message "hi"' -WhatIf | Out-Null
        }

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Expression -Times 0 -Exactly -Scope It
    }
}

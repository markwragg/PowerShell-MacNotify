# This runs all PSScriptAnalyzer rules as Pester tests to enable visibility when publishing test results
BeforeDiscovery {
    $ScriptAnalyzerSettingsPath = Join-Path -Path $env:BHProjectPath -ChildPath 'PSScriptAnalyzerSettings.psd1'
    $analysis = Invoke-ScriptAnalyzer -Path $env:BHModulePath -Recurse -Settings $ScriptAnalyzerSettingsPath

    # Built as test cases (rather than looping forEach { It { ... } } directly) because a plain
    # loop's $rule/$analysis variables are shared by reference across every It scriptblock it
    # creates -- under Pester's discovery/run split they'd all end up resolving to the loop's
    # final value at run time instead of the value from their own iteration.
    $ScriptAnalyzerRuleCases = Get-ScriptAnalyzerRule | ForEach-Object {
        $RuleName = $_.RuleName
        @{
            RuleName = $RuleName
            Failures = @($analysis | Where-Object { $_.RuleName -eq $RuleName })
        }
    }
}

Describe 'Testing against PSSA rules' {
    Context 'PSSA Standard Rules' {
        It "Should pass <RuleName>" -ForEach $ScriptAnalyzerRuleCases {
            $Failures | Out-Default
            $Failures.Count | Should -Be 0
        }
    }
}

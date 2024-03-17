if (-not $PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }

$PSVersion = $PSVersionTable.PSVersion.Major
$Root = "$PSScriptRoot/../"
$Module = 'MacNotify'

Get-Module $Module | Remove-Module -Force
Import-Module "$Root/$Module" -Force

Describe "Invoke-MacNotification PS$PSVersion" {

    InModuleScope MacNotify {
        Mock Invoke-AppleScript {}

        It 'Should send a simple message' {
            Invoke-MacNotification -Message 'Hello' | Should -Be $null
            Assert-MockCalled Invoke-AppleScript -Times 1 -Exactly -Scope It
        }
        It 'Should send a message with a title' {
            Invoke-MacNotification -Message Hi -Title 'Test Title' | Should -Be $null
            Assert-MockCalled Invoke-AppleScript -Times 1 -Exactly -Scope It
        }
        It 'Should send a message with a subtitle' {
            Invoke-MacNotification -Message 'How are you' -Subtitle 'Test Subtitle' | Should -Be $null
            Assert-MockCalled Invoke-AppleScript -Times 1 -Exactly -Scope It
        }
    }
}
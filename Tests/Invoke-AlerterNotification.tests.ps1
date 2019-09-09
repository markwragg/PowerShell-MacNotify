if (-not $PSScriptRoot) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }

$PSVersion = $PSVersionTable.PSVersion.Major
$Root = "$PSScriptRoot/../"
$Module = 'MacNotify'

Get-Module $Module | Remove-Module -Force
Import-Module "$Root/$Module" -Force

Describe "Invoke-AlerterNotification PS$PSVersion" {
    
    InModuleScope MacNotify {
        Mock Invoke-Alerter {}

        It 'Should send a simple message' {
            Invoke-AlerterNotification -Message 'Hello' | Should -Be $null
            Assert-MockCalled Invoke-Alerter -Times 1 -Exactly -Scope It
        }
        It 'Should send a message with a title' {
            Invoke-AlerterNotification -Message Hi -Title 'Test Title' | Should -Be $null
            Assert-MockCalled Invoke-Alerter -Times 1 -Exactly -Scope It
        }
        It 'Should send a message with a subtitle' {
            Invoke-AlerterNotification -Message 'How are you' -Subtitle 'Test Subtitle' | Should -Be $null
            Assert-MockCalled Invoke-Alerter -Times 1 -Exactly -Scope It
        }
    }   
}
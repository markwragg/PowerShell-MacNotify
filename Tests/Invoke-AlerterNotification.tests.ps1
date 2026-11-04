BeforeAll {
    $Root = "$PSScriptRoot/.."
    $Module = 'MacNotify'

    Get-Module $Module | Remove-Module -Force
    Import-Module "$Root/$Module" -Force

    Mock -ModuleName $Module Invoke-Alerter {
        '{"activationType":"timeout","deliveredAt":"2024-01-01T09:00:00.000Z","activationAt":"2024-01-01T09:00:05.000Z"}'
    }
    Mock -ModuleName $Module Invoke-Expression {}
}

Describe 'Invoke-AlerterNotification' {
    It 'Should send a simple message' {
        $Result = Invoke-AlerterNotification -Message 'Hello'

        $Result.activationType | Should -Be 'timeout'
        $Result.deliveredAt | Should -BeOfType [DateTime]
        $Result.activationAt | Should -BeOfType [DateTime]

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "Hello" -title "PowerShell Notification" -json'
        }
    }

    It 'Should send a message with a title' {
        Invoke-AlerterNotification -Message Hi -Title 'Test Title' | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "Hi" -title "Test Title" -json'
        }
    }

    It 'Should send a message with a subtitle' {
        Invoke-AlerterNotification -Message 'How are you' -Subtitle 'Test Subtitle' | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "How are you" -title "PowerShell Notification" -subtitle "Test Subtitle" -json'
        }
    }

    It 'Should send a message with a sound' {
        Invoke-AlerterNotification -Message 'Ding' -Sound 'Frog' | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "Ding" -title "PowerShell Notification" -sound "Frog" -json'
        }
    }

    It 'Should send a message with a timeout' {
        Invoke-AlerterNotification -Message 'Ding' -Timeout 30 | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "Ding" -title "PowerShell Notification" -timeout 30 -json'
        }
    }

    It 'Should send a message with an app icon' {
        Invoke-AlerterNotification -Message 'Ding' -AppIcon 'https://example.com/icon.png' | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "Ding" -title "PowerShell Notification" -appIcon "https://example.com/icon.png" -json'
        }
    }

    It 'Should send a message with a content image' {
        Invoke-AlerterNotification -Message 'Ding' -ContentImage 'https://example.com/pic.png' | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "Ding" -title "PowerShell Notification" -contentImage "https://example.com/pic.png" -json'
        }
    }

    It 'Should escape double quotes in the message, title and subtitle' {
        Invoke-AlerterNotification -Message 'Say "hi"' -Title 'A "title"' -Subtitle 'A "subtitle"' | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "Say ""hi""" -title "A ""title""" -subtitle "A ""subtitle""" -json'
        }
    }

    It 'Should not progressively double-escape a quoted title across multiple messages in one call' {
        Invoke-AlerterNotification -Message 'First', 'Second' -Title 'A "title"' | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "First" -title "A ""title""" -json'
        }
        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "Second" -title "A ""title""" -json'
        }
    }

    It 'Should not JSON-parse the result and omit -json when -Raw is used' {
        Mock -ModuleName MacNotify Invoke-Alerter { '@TIMEOUT' }

        Invoke-AlerterNotification -Message 'Ding' -Raw | Should -Be '@TIMEOUT'

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Alerter -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq '-message "Ding" -title "PowerShell Notification"'
        }
    }

    It 'Should not return a result when -Silent is used' {
        Invoke-AlerterNotification -Message 'Ding' -Silent | Should -BeNullOrEmpty
    }

    It 'Should open the -Open target when the notification is clicked' {
        Mock -ModuleName MacNotify Invoke-Alerter {
            '{"activationType":"actionClicked"}'
        }

        Invoke-AlerterNotification -Message 'Ding' -Open 'https://example.com' | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Expression -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq 'open https://example.com'
        }
    }

    It 'Should not open the -Open target when the notification times out' {
        Invoke-AlerterNotification -Message 'Ding' -Open 'https://example.com' | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Expression -Times 0 -Exactly -Scope It
    }

    It 'Should open the -Open target for a raw @ACTIONCLICKED result' {
        Mock -ModuleName MacNotify Invoke-Alerter { '@ACTIONCLICKED' }

        Invoke-AlerterNotification -Message 'Ding' -Open 'https://example.com' -Raw | Out-Null

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-Expression -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq 'open https://example.com'
        }
    }
}

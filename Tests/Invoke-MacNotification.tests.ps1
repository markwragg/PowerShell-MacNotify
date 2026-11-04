BeforeAll {
    $Root = "$PSScriptRoot/.."
    $Module = 'MacNotify'

    Get-Module $Module | Remove-Module -Force
    Import-Module "$Root/$Module" -Force

    Mock -ModuleName $Module Invoke-AppleScript {}
}

Describe 'Invoke-MacNotification' {
    It 'Should send a simple message' {
        Invoke-MacNotification -Message 'Hello' | Should -BeNullOrEmpty

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-AppleScript -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq 'display notification "Hello" with title "PowerShell Notification"'
        }
    }

    It 'Should send a message with a title' {
        Invoke-MacNotification -Message Hi -Title 'Test Title' | Should -BeNullOrEmpty

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-AppleScript -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq 'display notification "Hi" with title "Test Title"'
        }
    }

    It 'Should send a message with a subtitle' {
        Invoke-MacNotification -Message 'How are you' -Subtitle 'Test Subtitle' | Should -BeNullOrEmpty

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-AppleScript -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq 'display notification "How are you" with title "PowerShell Notification" subtitle "Test Subtitle"'
        }
    }

    It 'Should send a message with a sound' {
        Invoke-MacNotification -Message 'Ding' -Sound 'Frog' | Should -BeNullOrEmpty

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-AppleScript -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq 'display notification "Ding" with title "PowerShell Notification" sound name "Frog"'
        }
    }

    It 'Should escape double quotes in the message, title and subtitle' {
        Invoke-MacNotification -Message 'Say "hi"' -Title 'A "title"' -Subtitle 'A "subtitle"' | Should -BeNullOrEmpty

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-AppleScript -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq 'display notification "Say \"hi\"" with title "A \"title\"" subtitle "A \"subtitle\""'
        }
    }

    It 'Should send one notification per pipeline input message' {
        1, 2, 3 | Invoke-MacNotification -Title 'Numbers' | Should -BeNullOrEmpty

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-AppleScript -Times 3 -Exactly -Scope It
    }

    It 'Should not progressively double-escape a quoted title across multiple messages in one call' {
        Invoke-MacNotification -Message 'First', 'Second' -Title 'A "title"' | Should -BeNullOrEmpty

        Should -Invoke -ModuleName MacNotify -CommandName Invoke-AppleScript -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq 'display notification "First" with title "A \"title\""'
        }
        Should -Invoke -ModuleName MacNotify -CommandName Invoke-AppleScript -Times 1 -Exactly -Scope It -ParameterFilter {
            $Command -eq 'display notification "Second" with title "A \"title\""'
        }
    }
}

# PowerShell-MacNotify

[![Build status](https://ci.appveyor.com/api/projects/status/5am4rqhoegc791mb?svg=true)](https://ci.appveyor.com/project/markwragg/powershell-macnotify) ![Test Coverage](https://img.shields.io/badge/coverage-50%25-red.svg?maxAge=60)

This PowerShell module contains a cmdlet for triggering a notification to appear on MacOS.

## Installation

The module is published in the PSGallery, so can be installed by running:

```
Install-Module MacNotify -Scope CurrentUser
```

## Requires

- Mac OSX (Currently only tested on 10.14 Mojave).
- PowerShell Core 6.0+

## Usage

### Invoke-MacNotification

You can use `Invoke-MacNotification` to trigger a notification to appear. You must minimally specify the message text to display via `-Message`, the pipeline or as the first positional parameter.

**Examples:**
```
Invoke-MacNotification -Message 'Hello!'

Invoke-MacNotification Hello -Sound Frog

Invoke-MacNotification 'How are you?' -Title 'Some title'

Invoke-MacNotification 'Some message' -Title 'Some title' -Subtitle 'Some subtitle' -Sound 'Ping'

1,2,3 | Invoke-MacNotification -Title 'Numbers'

Invoke-MacNotification Hi
```

Note: the `-Sound` parameter uses a class to get a dynamic list of the available sound files under the default sound paths. As such you must specify the name of a sound from one of these locations for this parameter (or see tab completion for the parameter for the available options):

- '/System/Library/Sounds/'
- '/Library/Sounds'
- '~/Library/Sounds'

## Examples

For usage examples, see the /Examples folder.

## Cmdlets

A full list of cmdlets in this module is provided below for reference. Use `Get-Help <cmdlet name>` with these to learn more about their usage.

Cmdlet           | Description
-----------------| -------------------------------------------------------------------------------------------------------
Invoke-MacNotification | Triggers a notification to appear in OSX with the specified message and optional title, subtitle and sound alert.

# PowerShell-MacNotify

This PowerShell module contains a cmdlet for triggering a notification to appear on MacOS.

# Installation

The module is published in the PSGallery, so can be installed by running:

```
Install-Module MacNotify -Scope CurrentUser
```

## Usage

### Invoke-MacNotification

You can use `Invoke-MacNotification` to trigger a notification to appear. You must as a minimum specify the message text to display via `-Message`.

# Change Log

## [1.1.32] - 2026-11-04

* Fixed `Invoke-Alerter` resolving the bundled `alerter` binary via a path relative to its own source file. This happened to work when running from a dev checkout, but broke for every module installed via `Install-Module`/the PowerShell Gallery, where all functions are combined into a single file at the module root during build -- `Invoke-AlerterNotification` would fail to find `alerter` at all once installed.
* Fixed `Invoke-AlerterNotification` dropping every message after the first when more than one `-Message` value was passed in a single call (e.g. `-Message 'First','Second'`), caused by a `Return` inside the per-message loop that exited the whole function instead of just that iteration. Pipeline input (e.g. `1,2,3 | Invoke-AlerterNotification`) was not affected.
* Fixed `Invoke-MacNotification` and `Invoke-AlerterNotification` progressively double-escaping an already-escaped `-Title`/`-Subtitle` containing double quotes when more than one message was processed in a single call.
* Added test coverage for the above, plus the previously untested `Invoke-Alerter` and `Invoke-AppleScript` private functions and several untested `Invoke-AlerterNotification` parameters/branches (`-Sound`, `-Timeout`, `-AppIcon`, `-ContentImage`, `-Open`, `-Raw`, `-Silent`).

## [1.1.31] - 2024-09-03

* Fixed module unintentionally exposing private functions per [#5](https://github.com/markwragg/PowerShell-MacNotify/issues/5). (Thanks [@ElianFabian](https://github.com/ElianFabian)!)

## [1.1.30] - 2024-03-17

* Fixed Invoke-MacNotification and Invoke-AlertNotification to handle single or double quotes in the message, title or subtitle. Fixes #3.

## [1.1.29] - 2024-03-17

This version of MacNotify has been tested under MacOS 14 and works. It may not work in earlier versions. Version 1.1.27 was tested and working in MacOS 10.

* Removed class for soundnames and hard coded to default values instead, as the class was not loading in PowerShell 7.
* Updated Alerter to latest build
* Removed escape characters when executing Invoke-MacNotification, these were breaking the function in MacOS 14.

## [1.1.28] - 2024-03-17

* Test deployment having removed dependency of PSDeploy due to issues on MacOS.

## [1.1.27] - 2019-09-09

* Initial deployment.

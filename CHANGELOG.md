# Change Log

## !Deploy

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

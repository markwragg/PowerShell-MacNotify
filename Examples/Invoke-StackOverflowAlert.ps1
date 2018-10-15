#! /usr/local/bin/pwsh -noprofile

#PowerShell script to notify when new PowerShell StackOverflow questions are published using 'Alerter', with the option
#to then open the question by clicking 'show'.

#To run via crontab every 5 mins:
# */5 * * * *  /usr/local/bin/pwsh /path/to/script/Invoke-StackOverflowAlert.ps1

[cmdletbinding()]
Param(
    $Category = 'PowerShell'
)

$LatestQuestion = Invoke-RestMethod "https://stackoverflow.com/feeds/tag?tagnames=$Category&sort=newest" | Select-Object -First 1

$LatestQuestionID = $LatestQuestion.ID
$QuestionTitle = $LatestQuestion.title.'#text'

$LatestQuestionPath = '/tmp/LatestQuestion.txt'

if (Test-Path $LatestQuestionPath) {
    $PrevQuestionID = Get-Content $LatestQuestionPath
}

If ($LatestQuestionID -ne $PrevQuestionID) {
    If (-not (Get-Module MacNotify -ListAvailable)) {
        Install-Module MacNotify -Scope CurrentUser
    }

    $AlerterParams = @{
        Title   = "New #$Category question"
        Message = $QuestionTitle
        Timeout = 30
        AppIcon = 'https://cdn.sstatic.net/Sites/stackoverflow/company/img/logos/so/so-icon.png'
        Open    = $LatestQuestionID
    }

    Invoke-AlerterNotification @AlerterParams -Silent

    $LatestQuestionID | Set-Content $LatestQuestionPath
}